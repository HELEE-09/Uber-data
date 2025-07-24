# Uber-data
This project involves exploratory data analysis (EDA) on Uber ride request data to identify key insights, trends, and business opportunities. The goal is to understand demand/supply gaps, traffic patterns, and driver availability across time, dates, and pickup points.

📁 Dataset
File Name: Uber Request Data.xlsx
Source: Provided for internal analysis (assumed to be from Kaggle or a similar dataset)
Total Records: ~6,500
Key Columns:
Request id
Pickup point
Driver id
Status
Request timestamp
Drop timestamp

🎯 Objectives
Analyze ride request patterns by hour, day, and location.
Identify peak request times and unmet demand.
Understand supply-demand gap across pickup points.
Discover operational inefficiencies.

🧰 Tools & Technologies
Language: Python 3
Libraries: Pandas, NumPy, Matplotlib, Seaborn, datetime
Environment: Jupyter Notebook / Google Colab

🔍 Key Insights
High Demand Gap: Notably during morning (airport to city) and evening (city to airport) hours.
No Cars Available: Major reason for unfulfilled requests during peak times.
Traffic Delays: Contributing to trip cancellations and low driver availability.
Time Analysis: Most requests occur between 5 PM and 10 PM, and from 5 AM to 9 AM.
Driver ID Nulls: Requests with status “Cancelled” or “No Cars Available” often have missing Driver IDs.

📊 Visualizations
Bar plots for request frequency by hour.
Heatmaps showing demand vs. supply gaps.
Line graphs of trip status trends over time.
Pie chart showing overall distribution of statuses.

📌 Conclusion
This analysis reveals critical demand-supply gaps in Uber's service during specific time windows and pickup locations. Strategies like driver surge activation, predictive demand allocation, and improved ETA transparency can help mitigate these issues.

🚀 Future Improvements
Build a predictive model to forecast ride demand.
Integrate weather or traffic data for better context.
Deploy dashboards using Power BI or Streamlit for real-time monitoring.
