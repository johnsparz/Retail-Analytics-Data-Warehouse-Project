/*
--------------------------------------
Create and Insert facts & dimension tables from Bronze to Silver
--------------------------------------
*/
DROP TABLE IF EXISTS silver.dim_stores;
GO
CREATE TABLE silver.dim_stores (
    store_id        NVARCHAR(20) PRIMARY KEY,
    store_name      NVARCHAR(100),
    category        NVARCHAR(50),
    floor           INT,
    opened_year     INT,
    load_timestamp  DATETIME2 DEFAULT SYSDATETIME()
);
INSERT INTO silver.dim_stores
SELECT
    store_id,
    store_name,
    category,
    floor,
    opened_year,
    SYSDATETIME()
FROM bronze.stores;


CREATE TABLE silver.dim_products (
    product_id      NVARCHAR(50) PRIMARY KEY,
    product_name    NVARCHAR(100),
    category        NVARCHAR(50),
    brand           NVARCHAR(50),
    unit_cost       DECIMAL(10,2),
    unit_price      DECIMAL(10,2),
    load_timestamp  DATETIME2 DEFAULT SYSDATETIME()
);
INSERT INTO silver.dim_products (
    product_id,
    product_name,
    category,
    brand,
    unit_cost,
    unit_price
)
SELECT
    product_id,
    product_name,
    category,
    'Babadox' AS brand,
    CAST(base_price * 0.65 AS DECIMAL(10,2)) AS unit_cost,
    CAST(base_price AS DECIMAL(10,2)) AS unit_price
--new column added afterward
FROM bronze.products;
ALTER TABLE silver.dim_products
ADD store_id NVARCHAR(20);

UPDATE p
SET p.store_id = b.store_id
FROM silver.dim_products p
JOIN bronze.products b
    ON p.product_id = b.product_id;
    --optional
ALTER TABLE silver.dim_products
ALTER COLUMN store_id NVARCHAR(20) NOT NULL;



CREATE TABLE silver.dim_promotions (
    promo_id    NVARCHAR(50) PRIMARY KEY,
    promo_type  NVARCHAR(50),
    discount_pct    DECIMAL(5,2),
    start_date      DATE,
    end_date        DATE,
    load_timestamp  DATETIME2 DEFAULT SYSDATETIME()
);
INSERT INTO silver.dim_promotions
SELECT
    promo_id,
    promo_type,
    discount_pct,
    start_date,
    end_date,
    SYSDATETIME()
FROM bronze.promotions
WHERE discount_pct BETWEEN 0 AND 100;


DROP TABLE IF EXISTS silver.dim_customers;
GO
CREATE TABLE silver.dim_customers (
    customer_id     NVARCHAR(50) PRIMARY KEY,
    gender          NVARCHAR(10),
    age             INT,
    age_group       NVARCHAR(20),
    loyalty_tier    NVARCHAR(20),
    join_date       DATE,
    city            NVARCHAR(50),
    load_timestamp  DATETIME2 DEFAULT SYSDATETIME()
);
INSERT INTO silver.dim_customers (
    customer_id,
    gender,
    age,
    age_group,
    loyalty_tier,
    join_date,
    city,
    load_timestamp
)
SELECT
    customer_id,
    gender,
    age,
    CASE
        WHEN age < 18 THEN 'Under 18'
        WHEN age BETWEEN 18 AND 24 THEN '18�24'
        WHEN age BETWEEN 25 AND 34 THEN '25�34'
        WHEN age BETWEEN 35 AND 44 THEN '35�44'
        WHEN age BETWEEN 45 AND 54 THEN '45�54'
        WHEN age BETWEEN 55 AND 64 THEN '55�64'
        ELSE '65+'
    END AS age_group,
    loyalty_tier,
    join_date,
    city,
    SYSDATETIME()
FROM bronze.customers;


DROP TABLE IF EXISTS silver.fact_inventory_snapshot;
GO
CREATE TABLE silver.fact_inventory_snapshot (
    product_id      NVARCHAR(50) NOT NULL,
    snapshot_date   DATE NOT NULL,
    stock_on_hand   INT NOT NULL,
    reorder_level   INT NOT NULL,
    load_timestamp  DATETIME2 DEFAULT SYSDATETIME(),
    CONSTRAINT pk_fact_inventory PRIMARY KEY (product_id, snapshot_date)
);
INSERT INTO silver.fact_inventory_snapshot
(
    product_id,
    snapshot_date,
    stock_on_hand,
    reorder_level
)
SELECT
    product_id,
    snapshot_date,
    stock_on_hand,
    reorder_level
FROM bronze.inventory_snapshot
WHERE stock_on_hand >= 0;


CREATE TABLE silver.fact_store_traffic (
    store_id        NVARCHAR(20),
    traffic_date    DATE,
    visitor_count   INT NOT NULL,
    load_timestamp  DATETIME2 DEFAULT SYSDATETIME(),
    CONSTRAINT pk_store_traffic PRIMARY KEY (store_id, traffic_date)
);
INSERT INTO silver.fact_store_traffic
SELECT
    store_id,
    [date] AS traffic_date,
    visitor_count,
    SYSDATETIME()
FROM bronze.store_foot_traffic
WHERE visitor_count >= 0;


INSERT INTO silver.fact_transactions (
    transaction_id,
    transaction_date,
    customer_id,
    product_id,
    quantity,
    unit_price,
    discount_pct,
    total_amount,
    payment_method,
    load_timestamp
)
SELECT
    t.transaction_id,
    t.transaction_date,
    t.customer_id,
    t.product_id,
    t.quantity,
    CAST(t.total_amount / NULLIF(t.quantity, 0) AS DECIMAL(10,2)) AS unit_price,
    CASE 
        WHEN t.discount_pct BETWEEN 0 AND 100 THEN t.discount_pct
        ELSE NULL
    END AS discount_pct,
    t.total_amount,
    t.payment_method,
    SYSDATETIME()
FROM bronze.transactions_dirty t
JOIN bronze.customers c 
    ON t.customer_id = c.customer_id
JOIN bronze.products p 
    ON t.product_id = p.product_id
WHERE
    t.transaction_id IS NOT NULL
    AND t.quantity > 0
    AND t.total_amount >= 0;


DROP TABLE IF EXISTS silver.fact_returns;
GO
CREATE TABLE silver.fact_returns (
    transaction_id NVARCHAR(50) NOT NULL,
    product_id     NVARCHAR(50) NOT NULL,
    customer_id    NVARCHAR(50) NOT NULL,
    return_date    DATE NOT NULL,
    refund_amount  FLOAT NOT NULL,
    load_timestamp DATETIME2 DEFAULT SYSDATETIME(),
    CONSTRAINT pk_fact_returns PRIMARY KEY (transaction_id, product_id)
);
INSERT INTO silver.fact_returns
(
    transaction_id,
    product_id,
    customer_id,
    return_date,
    refund_amount
)
SELECT
    r.transaction_id,
    r.product_id,
    r.customer_id,
    r.return_date,
    r.refund_amount
FROM bronze.returns r
WHERE
    r.transaction_id IS NOT NULL
    AND r.refund_amount > 0;

--This is a joined table
DROP TABLE IF EXISTS silver.fact_sales_net;
GO
CREATE TABLE silver.fact_sales_net (
    transaction_id NVARCHAR(50),
    product_id     NVARCHAR(50),
    customer_id    NVARCHAR(50),
    sales_date     DATE,
    quantity       INT,
    unit_price     FLOAT,
    gross_amount   FLOAT,
    refund_amount  FLOAT,
    net_amount     FLOAT,
    load_timestamp DATETIME2 DEFAULT SYSDATETIME(),
    CONSTRAINT pk_fact_sales_net PRIMARY KEY (transaction_id, product_id)
);
INSERT INTO silver.fact_sales_net
SELECT
    t.transaction_id,
    t.product_id,
    t.customer_id,
    t.transaction_date AS sales_date,
    t.quantity,
    t.unit_price,
    t.total_amount AS gross_amount,
    ISNULL(r.refund_amount, 0) AS refund_amount,
    t.total_amount - ISNULL(r.refund_amount, 0) AS net_amount,
    SYSDATETIME()
FROM silver.fact_transactions t
LEFT JOIN silver.fact_returns r
    ON t.transaction_id = r.transaction_id
   AND t.product_id = r.product_id;











