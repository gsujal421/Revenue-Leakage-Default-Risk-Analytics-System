use revenue;

-- 1
drop table if exists stage_customer;
CREATE TABLE stage_customer AS SELECT customer_id,
    TRIM(name) AS name,
    TRIM(seg) AS seg,
    STR_TO_DATE(signup_date, '%Y-%m-%d') AS signup_date,
    TRIM(region) AS region,
    credit_score FROM
    customers;

-- 2
drop table if exists stage_invoice;
CREATE TABLE stage_invoice AS SELECT invoice_id,
    order_id,
    STR_TO_DATE(invoice_date, '%Y-%m-%d') AS invoice_date,
    STR_TO_DATE(due_date, '%Y-%m-%d') AS due_date,
    CASE
        WHEN paid_date = '' THEN NULL
        ELSE STR_TO_DATE(paid_date, '%Y-%m-%d')
    END AS paid_date,
    amount,
    amount_paid,
    TRIM(payment_status) AS payment_status FROM
    invoices;

-- 3
drop table if exists stage_orders;
CREATE TABLE stage_orders AS SELECT order_id,
    customer_id,
    STR_TO_DATE(order_date, '%Y-%m-%d') AS order_date,
    sku,
    qty,
    price,
    discount,
    TRIM(status) AS status,
    sales_rep_id FROM
    orders;

-- 4
drop table if exists stage_payment;
CREATE TABLE stage_payment AS SELECT payment_id,
    invoice_id,
    STR_TO_DATE(payment_date, '%Y-%m-%d') AS payment_date,
    amount,
    TRIM(success_flag) AS success_flag FROM
    payments;

-- 5
drop table if exists stage_products;
CREATE TABLE stage_products AS SELECT sku, TRIM(category) AS category, cost_price, list_price FROM
    products;

-- 6
drop table if exists stage_returns;
CREATE TABLE stage_returns AS SELECT return_id,
    order_id,
    STR_TO_DATE(return_date, '%Y-%m-%d') AS return_date,
    qty,
    refund_amount,
    TRIM(reason) AS reason FROM
    returns;

-- 7
drop table if exists stage_sales_reps;
CREATE TABLE stage_sales_reps AS SELECT sales_rep_id,
    TRIM(name) AS name,
    TRIM(territory) AS territory,
    quota FROM
    sales_reps;
