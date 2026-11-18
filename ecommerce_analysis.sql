-- 1. Overall Business & Logistics KPIs
SELECT 
    COUNT(*) AS total_orders,
    SUM(is_delayed) AS delayed_orders,
    ROUND(AVG(is_delayed) * 100, 2) AS overall_delay_rate_pct,
    ROUND(AVG(customer_rating)::numeric, 2) AS avg_customer_rating,
    SUM(cost_of_the_product) AS total_product_value
FROM ecommerce_orders;

-- 2. Shipping Mode Performance (Flight vs Ship vs Road)
SELECT 
    mode_of_shipment,
    COUNT(*) AS total_orders,
    ROUND(AVG(is_delayed) * 100, 2) AS delay_rate_pct,
    ROUND(AVG(customer_rating)::numeric, 2) AS avg_rating,
    ROUND(AVG(cost_of_the_product)::numeric, 2) AS avg_order_value
FROM ecommerce_orders
GROUP BY mode_of_shipment
ORDER BY delay_rate_pct DESC;

-- 3. Warehouse Block Bottleneck Analysis
SELECT 
    warehouse_block,
    COUNT(*) AS total_orders,
    ROUND(AVG(is_delayed) * 100, 2) AS delay_rate_pct,
    ROUND(AVG(customer_care_calls)::numeric, 2) AS avg_support_calls
FROM ecommerce_orders
GROUP BY warehouse_block
ORDER BY delay_rate_pct DESC;

-- 4. Discount Tier & Package Weight Impact on Delays
SELECT 
    discount_tier,
    weight_category,
    COUNT(*) AS total_orders,
    ROUND(AVG(is_delayed) * 100, 2) AS delay_rate_pct
FROM ecommerce_orders
GROUP BY discount_tier, weight_category
ORDER BY delay_rate_pct DESC;

-- 5. Customer Frustration Analysis (Support Calls vs Rating & Delay)
WITH call_analysis AS (
    SELECT 
        customer_care_calls,
        COUNT(*) AS total_customers,
        ROUND(AVG(is_delayed) * 100, 2) AS delay_pct,
        ROUND(AVG(customer_rating)::numeric, 2) AS avg_rating,
        ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS pct_of_total_orders
    FROM ecommerce_orders
    GROUP BY customer_care_calls
)
SELECT * 
FROM call_analysis
ORDER BY customer_care_calls ASC;