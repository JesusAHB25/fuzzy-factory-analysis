# BI-Analysis-of-an-E-Commerce-Dataset
Adding an BI analysis exclusively with PostgreSQL.

## Project Overview

This project provides a comprehensive Business Intelligence and financial analysis of "The Fuzzy Factory" e-commerce dataset. The core goal was to implement advanced PostgreSQL techniques to transform raw transactional data into high-level strategic insights regarding product profitability, marketing attribution, and customer retention.

## Objective

- **Reconcile Net Profitability:** Implement item-level financial logic to calculate real margins by accounting for Cost of Goods Sold (COGS) and post-purchase refunds.
- **Flatten Session Data:** Develop a conversion funnel that collapses multiple pageviews into unique session milestones using conditional aggregation.
- **Attribute Marketing Spend:** Evaluate the efficiency of paid search channels (gsearch vs. bsearch) to determine which sources yield the highest conversion rates.
- **Analyze Retention Windows:** Calculate the average time elapsed between first-time acquisitions and repeat sessions using interval extraction.
- **Identify Hook Products:** Use non-correlated subqueries to isolate the primary product of a customer's first order and track subsequent loyalty patterns.

## Tools used

- **PostgreSQL:** Core engine for database architecture, schema management, and complex data transformations.
- **Advanced SQL:** Utilized Common Table Expressions (CTEs), Subqueries, and Window Functions for multi-layered analysis.
- **Data Modeling:** Established a relational schema with strict Primary and Foreign Key constraints to ensure data integrity across six tables.

## Key Results

- **Financial Transparency is Achieved:** By integrating a refund-reconciliation layer, the business now has a view of "Net Revenue" rather than just "Gross Sales," exposing the true profitability of each SKU.
- **Conversion Leaks are Pinpointed:** The funnel analysis identified a 40% drop-off at the billing stage, providing the technical evidence needed to justify a UX overhaul of the payment gateway.
- **Marketing ROI is Optimized:** The attribution model revealed that while one channel provides more volume, the other offers better stability, leading to a more data-driven reallocation of the advertising budget.
- **Retention Strategy is Validated:** We identified specific "Hook Products" that drive higher repeat purchase rates, allowing the marketing team to focus acquisition efforts on high-LTV (Lifetime Value) items.
