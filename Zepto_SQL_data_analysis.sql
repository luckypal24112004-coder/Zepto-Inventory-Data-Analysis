-- ================================
-- Zepto E-commerce SQL Project 
-- ================================

-- =========================
-- 1. Table Creation 
-- =========================
DROP TABLE IF EXISTS zepto;

CREATE TABLE zepto (
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(120) NOT NULL,
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2) NOT NULL CHECK (mrp > 0),
    discountPercent NUMERIC(5,2) NOT NULL CHECK (discountPercent BETWEEN 0 AND 100),
    availableQuantity INTEGER DEFAULT 0,
    discountedSellingPrice NUMERIC(8,2) NOT NULL CHECK (discountedSellingPrice >= 0),
    weightInGms INTEGER DEFAULT 0 CHECK (weightInGms >= 0),
    outOfStock BOOLEAN DEFAULT FALSE,
    quantity INTEGER DEFAULT 0
);

-- =========================
-- 2. Data Cleaning
-- =========================

-- Remove invalid prices (0 or negative)
DELETE FROM zepto
WHERE mrp <= 0 OR discountedSellingPrice <= 0;

-- Convert paise to rupees (run only once if prices are in paise)
UPDATE zepto
SET mrp = ROUND(mrp / 100.0, 2),
    discountedSellingPrice = ROUND(discountedSellingPrice / 100.0, 2);

-- =========================
-- 3. Data Exploration
-- =========================

-- Total number of products
SELECT COUNT(*) AS total_products FROM zepto;

-- Sample 10 products
SELECT * FROM zepto
LIMIT 10;

-- Check for null values in key columns
SELECT *
FROM zepto
WHERE category IS NULL
   OR name IS NULL
   OR mrp IS NULL
   OR discountPercent IS NULL
   OR discountedSellingPrice IS NULL
   OR weightInGms IS NULL
   OR availableQuantity IS NULL
   OR outOfStock IS NULL;

-- List of unique categories
SELECT DISTINCT category
FROM zepto
ORDER BY category;

-- Products in stock vs out of stock
SELECT outOfStock, COUNT(sku_id) AS product_count
FROM zepto
GROUP BY outOfStock;

-- Duplicate product names
SELECT name, COUNT(sku_id) AS number_of_skus
FROM zepto
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY number_of_skus DESC;

-- =========================
-- 4. Data Analysis
-- =========================

-- Q1. Top 10 best-value products (highest discount)
SELECT name, category, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

-- Q2. Products with high MRP (> 300) but out of stock
SELECT name, category, mrp
FROM zepto
WHERE outOfStock = TRUE
  AND mrp > 300
ORDER BY mrp DESC;

-- Q3. Potential revenue per category
SELECT category, 
       SUM(discountedSellingPrice * availableQuantity) AS potential_revenue
FROM zepto
GROUP BY category
ORDER BY potential_revenue DESC;

-- Q4. High price (> 500) but low discount (< 10%)
SELECT name, category, mrp, discountPercent
FROM zepto
WHERE mrp > 500
  AND discountPercent < 10
ORDER BY mrp DESC, discountPercent ASC;

-- Q5. Top 5 categories by average discount
SELECT category, ROUND(AVG(discountPercent), 2) AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

-- Q6. Price per gram for products >= 100g (best value)
SELECT name, category, weightInGms, discountedSellingPrice,
       ROUND(discountedSellingPrice / weightInGms, 2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram ASC;

-- Q7. Product weight classification (Low / Medium / Bulk)
SELECT name, category, weightInGms,
       CASE
           WHEN weightInGms < 500 THEN 'Low'
           WHEN weightInGms BETWEEN 500 AND 2000 THEN 'Medium'
           ELSE 'Bulk'
       END AS weight_category
FROM zepto
ORDER BY weightInGms ASC;

-- Q8. Total inventory weight per category
SELECT category,
       SUM(weightInGms * availableQuantity) AS total_inventory_weight
FROM zepto
GROUP BY category
ORDER BY total_inventory_weight DESC;

-- Q9. Top 3 products by revenue per category
SELECT category, name,
       (discountedSellingPrice * availableQuantity) AS product_revenue
FROM zepto
QUALIFY ROW_NUMBER() OVER (PARTITION BY category ORDER BY (discountedSellingPrice * availableQuantity) DESC) <= 3
ORDER BY category, product_revenue DESC;

-- Q10. Discount efficiency (how much discount a product gives in ₹)
SELECT name, category, mrp, discountedSellingPrice,
       ROUND(mrp - discountedSellingPrice, 2) AS discount_value
FROM zepto
ORDER BY discount_value DESC
LIMIT 10;

-- Q11. Average price per category
SELECT category,
       ROUND(AVG(discountedSellingPrice), 2) AS avg_price
FROM zepto
GROUP BY category
ORDER BY avg_price DESC;

-- Q12. Stock value per category (how much inventory is worth)
SELECT category,
       SUM(discountedSellingPrice * availableQuantity) AS stock_value
FROM zepto
GROUP BY category
ORDER BY stock_value DESC;


