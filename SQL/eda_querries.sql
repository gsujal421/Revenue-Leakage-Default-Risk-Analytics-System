use revenue;

-- 1 AGING Bucket
SELECT 
    CASE
        WHEN invoice_age_days <= 0 THEN 'Not Due'
        WHEN invoice_age_days BETWEEN 1 AND 30 THEN '1-30'
        WHEN invoice_age_days BETWEEN 30 AND 90 THEN '30-90'
        WHEN invoice_age_days BETWEEN 90 AND 180 THEN '90-180'
        ELSE '180+'
    END AS bucket,
    COUNT(*),
    SUM(outstanding_payment) AS outstanding_payment
FROM
    clean_invoices
GROUP BY bucket
ORDER BY bucket;

-- 2 top 10 customer by outstanding
SELECT 
    c.customer_id,
    c.name,
    SUM(i.outstanding_payment) AS total_outstanding
FROM
    clean_customer c
        JOIN
    clean_orders o ON o.customer_id = c.customer_id
        JOIN
    clean_invoices i ON i.order_id = o.order_id
GROUP BY c.customer_id , c.name
ORDER BY total_outstanding DESC
LIMIT 10;

-- 3 Refund anamolies
SELECT 
    r.return_id, r.refund_amount, r.refund_pct, o.order_amount
FROM
    clean_returns r
        JOIN
    clean_orders o ON o.order_id = r.order_id
ORDER BY r.refund_pct;

-- 4 High refund customer
SELECT 
    customer_id,
    name,
    lifetime_amount,
    overall_refund_amount,
    overall_refund_amount / NULLIF(lifetime_amount, 0) AS ratio
FROM
    clean_customer
ORDER BY ratio DESC
LIMIT 10;

-- 5 Total revenue vs paid vs outstanding
SELECT 
    SUM(amount) AS total_revenue,
    SUM(total_paid) AS total_paid,
    SUM(outstanding_payment) AS total_outstanding_amount
FROM
    clean_invoices;

-- 6 Payment Behavior
SELECT 
    customer_id,
    name,
    over_due_invoices,
    total_invoices,
    ROUND(over_due_invoices / NULLIF(total_invoices, 0),
            2) AS late_ratio
FROM
    clean_customer
ORDER BY late_ratio DESC
LIMIT 10;