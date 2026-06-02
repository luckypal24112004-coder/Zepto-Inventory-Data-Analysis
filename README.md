# Zepto E-Commerce SQL Analysis

## Project Overview

This project analyzes product data from Zepto's e-commerce inventory using SQL.

The goal was to perform data cleaning, exploratory analysis, and business-focused analytics to uncover insights related to pricing, discounts, inventory, category performance, and revenue opportunities.

---

## Dataset Information

The dataset contains product-level information including:

- Product Name
- Category
- MRP
- Discount Percentage
- Available Quantity
- Discounted Selling Price
- Product Weight
- Stock Status

### Sample Columns

| Column | Description |
|----------|-------------|
| category | Product category |
| name | Product name |
| mrp | Maximum Retail Price |
| discountPercent | Discount offered |
| availableQuantity | Available inventory |
| discountedSellingPrice | Selling price after discount |
| weightInGms | Product weight |
| outOfStock | Stock availability |
| quantity | Unit quantity |

---

## Database Design

A single table named `zepto` was created with:

- Primary Key (`sku_id`)
- Data validation using CHECK constraints
- Inventory and pricing information

---

## Data Cleaning

The following cleaning steps were performed:

### Remove Invalid Products

Products with:

- MRP <= 0
- Selling Price <= 0

were removed.

### Standardize Currency

Prices stored in paise were converted into rupees.

---

## Exploratory Data Analysis

The following checks were performed:

- Total number of products
- Sample product inspection
- Null value detection
- Unique categories analysis
- Stock availability analysis
- Duplicate product identification

---

## Business Questions Solved

### 1. Best Value Products

Identify products with the highest discounts.

### 2. Premium Products Out of Stock

Find expensive products currently unavailable.

### 3. Potential Revenue by Category

Estimate revenue based on inventory levels.

### 4. High Price, Low Discount Products

Identify products that may be overpriced.

### 5. Categories Offering Highest Discounts

Compare average discounts across categories.

### 6. Price per Gram Analysis

Determine products providing the best value by weight.

### 7. Product Weight Segmentation

Classify products into:

- Low
- Medium
- Bulk

weight categories.

### 8. Inventory Weight Analysis

Measure total inventory weight across categories.

### 9. Top Revenue Generating Products per Category

Rank products using window functions.

### 10. Discount Efficiency Analysis

Calculate absolute savings provided by each product.

### 11. Average Product Price by Category

Compare pricing structures.

### 12. Inventory Stock Value Analysis

Estimate total inventory worth.

---

## SQL Concepts Demonstrated

### Data Definition Language (DDL)

- CREATE TABLE
- DROP TABLE

### Data Manipulation Language (DML)

- DELETE
- UPDATE

### Aggregations

- COUNT()
- SUM()
- AVG()

### Filtering

- WHERE
- HAVING

### Sorting

- ORDER BY
- LIMIT

### Conditional Logic

- CASE WHEN

### Window Functions

- ROW_NUMBER()

### Data Validation

- CHECK Constraints

---

## Key Skills Demonstrated

- SQL Data Cleaning
- Data Exploration
- Business Analysis
- Inventory Analytics
- Revenue Analysis
- Window Functions
- Aggregate Functions
- Query Optimization Concepts

---

## Tools Used

- PostgreSQL
- SQL

---

## Project Structure

├── README.md
├── zepto_sql_project.sql
├── dataset.csv
└── screenshots/

---

## Future Improvements

- Create category-level dashboards in Power BI
- Build inventory forecasting models
- Perform customer basket analysis
- Develop pricing optimization recommendations

---

## Author

Lucky

Aspiring Data Analyst

Skills: SQL | Python | Power BI | Excel
