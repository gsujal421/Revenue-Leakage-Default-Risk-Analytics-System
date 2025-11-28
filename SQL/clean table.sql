use revenue;

-- 1
drop table if exists clean_orders;
CREATE TABLE clean_orders AS SELECT order_id,
    customer_id,
    order_date,
    sku,
    COALESCE(qty, 0) AS qty,
    COALESCE(price, 0) AS price,
    COALESCE(discount, 0) AS discount,
    GREATEST(ROUND(COALESCE(qty, 0) * COALESCE(price, 0) - COALESCE(discount, 0),
                    2),
            0) AS order_amount,
    IFNULL(status, 'unknown') AS status,
    sales_rep_id FROM
    stage_orders;

-- 2
DROP TABLE IF EXISTS clean_payment;
CREATE TABLE clean_payment AS
SELECT
    invoice_id,
    SUM(COALESCE(amount, 0)) AS amount_paid
FROM stage_payment
GROUP BY invoice_id;


-- 3
DROP TABLE IF EXISTS clean_invoices;
CREATE TABLE clean_invoices AS
SELECT 
    i.invoice_id,
    i.order_id,
    i.invoice_date,
    i.due_date,
    i.paid_date,
    COALESCE(i.amount, 0)       AS amount,
    COALESCE(cp.amount_paid, 0) AS total_paid,
    CASE
        WHEN i.due_date IS NULL THEN NULL
        ELSE DATEDIFF(CURDATE(), i.due_date)
    END AS invoice_age_days,
    COALESCE(i.amount, 0) - COALESCE(cp.amount_paid, 0) AS outstanding_payment
FROM stage_invoice i
LEFT JOIN clean_payment cp
       ON TRIM(i.invoice_id) = TRIM(cp.invoice_id);


-- 4
DROP TABLE IF EXISTS clean_returns;
CREATE TABLE clean_returns AS SELECT r.return_id,
    r.order_id,
    r.return_date,
    COALESCE(r.qty, 0) AS qty,
    COALESCE(r.refund_amount, 0) AS refund_amount,
    r.reason,
    CASE
        WHEN
            o.order_amount IS NULL
                OR o.order_amount = 0
        THEN
            NULL
        ELSE r.refund_amount / o.order_amount
    END AS refund_pct FROM
    stage_returns r
        LEFT JOIN
    clean_orders o ON o.order_id = r.order_id;

-- 5
DROP TABLE IF EXISTS clean_customer;
CREATE TABLE clean_customer AS SELECT c.customer_id,
    c.name,
    c.seg,
    c.signup_date,
    c.region,
    c.credit_score,
    COALESCE(SUM(o.order_amount), 0) AS lifetime_amount,
    COUNT(DISTINCT o.order_id) AS total_orders,
    COUNT(DISTINCT i.invoice_id) AS total_invoices,
    SUM(CASE
        WHEN i.invoice_age_days > 30 THEN 1
        ELSE 0
    END) AS over_due_invoices,
    COALESCE(SUM(r.refund_amount), 0) AS overall_refund_amount FROM
    stage_customer c
        LEFT JOIN
    clean_orders o ON o.customer_id = c.customer_id
        LEFT JOIN
    clean_invoices i ON i.order_id = o.order_id
        LEFT JOIN
    clean_returns r ON r.order_id = i.order_id
GROUP BY c.customer_id , c.name , c.seg , c.signup_date , c.region , c.credit_score;

