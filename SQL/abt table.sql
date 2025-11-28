use revenue;
Drop table if exists abt;
CREATE TABLE abt AS 
SELECT
    i.invoice_id,
    i.order_id,
    i.invoice_date,
    i.due_date,
    i.paid_date,
    i.amount,
    i.total_paid,
    i.outstanding_payment,
    i.invoice_age_days,
    c.customer_id,
    c.name,
    c.seg,
    c.signup_date,
    c.region,
    c.credit_score,
    c.lifetime_amount,
    c.total_orders,
    c.total_invoices,
    c.over_due_invoices,
    c.overall_refund_amount FROM
    clean_customer c
        JOIN
    clean_orders o ON o.customer_id = c.customer_id
        JOIN
    clean_invoices i ON i.order_id = o.order_id;