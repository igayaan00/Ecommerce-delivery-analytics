import pandas as pd
from sqlalchemy import create_engine

# 1. Raw CSV Load Karein
df = pd.read_csv("ecommerce_orders.csv")
print(f"Raw data loaded: {df.shape[0]} rows, {df.shape[1]} columns")

# 2. Column Names Clean & Standardize Karein
df.columns = [col.strip().lower().replace(".", "_") for col in df.columns]
df.rename(columns={"reached_on_time_y_n": "is_delayed"}, inplace=True)

# 3. Duplicates aur Missing Values Check Karein
df.drop_duplicates(subset=["id"], inplace=True)
df.dropna(inplace=True)

# 4. Feature Engineering (Analysis ke liye naye readable columns)
# Is dataset mein 1 = Delayed aur 0 = On Time hota hai
df["delivery_status"] = df["is_delayed"].map({1: "Delayed", 0: "On Time"})

# Weight buckets banayein (Light, Medium, Heavy)
df["weight_category"] = pd.cut(
    df["weight_in_gms"],
    bins=[0, 2000, 4500, 10000],
    labels=["Light (<2kg)", "Medium (2-4.5kg)", "Heavy (>4.5kg)"]
)

# Discount tier banayein
df["discount_tier"] = df["discount_offered"].apply(
    lambda x: "High Discount (>20%)" if x > 20 else ("Moderate (10-20%)" if x >= 10 else "Low (<10%)")
)

print("Data cleaning & feature engineering complete!")

# 5. PostgreSQL Database se Connect Karein aur Data Load Karein
# DHYAN DEIN: 'YOUR_PASSWORD' ki jagah apna pgAdmin password dalein
db_url = "postgresql+psycopg://postgres:ayaan123@localhost:5432/ecommerce_db"
engine = create_engine(db_url)

df.to_sql("ecommerce_orders", engine, if_exists="replace", index=False)
print("Success! Clean data PostgreSQL table 'ecommerce_orders' mein load ho gaya hai.")


