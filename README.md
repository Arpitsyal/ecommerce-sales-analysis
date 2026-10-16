# E-Commerce Sales and Delivery Analysis

An exploratory analysis of the Brazilian Olist e-commerce dataset using SQL (SQLite), Python, Pandas, and Matplotlib.

## Objectives
- Analyze monthly order volume and recorded payment value.
- Identify product categories with the highest product sales value.
- Measure late-delivery rate and average purchase-to-delivery time.
- Compare review scores for late and on-time delivered orders.

## Tools
Python, Pandas, SQLite/SQL, Matplotlib, Google Colab.

## Dataset
Source: [Olist Brazilian E-Commerce Public Dataset on Kaggle](https://www.kaggle.com/olistbr/brazilian-ecommerce)

Raw data files are not included in this repository. Check the source page for dataset details and license/attribution requirements.

## Key Findings
- November 2017 had the highest monthly order count in the analyzed results: 7,544 orders, with recorded payment value of approximately R$1.19 million.
- Health & Beauty ranked first among the top 10 categories by product sales value (approximately R$1.26 million), followed by Watches & Gifts (approximately R$1.21 million).
- Among delivered orders with actual and estimated delivery dates, 7,826 were late. The calculated late-delivery rate was 8.11%, and average purchase-to-delivery time was 12.56 days.
- Late-delivered orders had an average review score of 2.57, compared with 4.29 for on-time orders. This is an association, not proof of causation.

## Visualizations
Add exported chart PNGs to the `charts/` folder and link them here:
- `monthly_order_trend.png`
- `monthly_payment_value_trend.png`
- `top_product_categories.png`
- `delivery_review_comparison.png`

## Project Files
- `ecommerce_analysis.ipynb` — export your notebook from Google Colab and add it here.
- `sql_analysis.sql` — SQL queries used in the analysis.
- `charts/` — charts exported from the notebook.
- `README.md` — project overview and findings.

## Limitations
- The dataset covers a historical period and one marketplace; results should not be generalized to all e-commerce businesses.
- The final months appear incomplete and should not be compared with full months without checking coverage.
- Product sales are calculated from item prices and exclude freight. Payment value is a separate metric and is not profit.
- Review-score comparisons show association, not causation.
