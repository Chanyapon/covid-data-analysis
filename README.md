# COVID-19 Data Exploration & Analysis 📊

![SQL](https://img.shields.io/badge/Language-SQL-orange)
![Database](https://img.shields.io/badge/Database-MS%20SQL%20Server-lightgrey)
![Status](https://img.shields.io/badge/Status-Completed-success)

## 📌 Project Overview

This project performs an **Exploratory Data Analysis (EDA)** on global COVID-19 data. The goal is to uncover trends in infection rates, death counts, and vaccination progress across different countries and continents.

The SQL queries in this repository demonstrate data manipulation skills, ranging from basic filtering to advanced techniques like **Window Functions** and **CTEs** to calculate rolling statistics.

Additionally, specific queries were created to prepare data for visualization in **Tableau/Power BI**.

---

## 🛠 Skills & Techniques Demonstrated

This project showcases the following SQL skills:

* **Joins:** Combining Death and Vaccination datasets.
* **CTEs (Common Table Expressions):** Calculating rolling vaccination numbers.
* **Temp Tables:** Storing intermediate calculations for reuse.
* **Windows Functions:** Using `OVER (PARTITION BY ...)` for cumulative aggregations.
* **Aggregate Functions:** `SUM`, `MAX`, `COUNT` for global and regional stats.
* **Data Type Conversion:** Using `CAST` and `CONVERT` for accurate calculations.
* **Data Cleaning:** Handling NULL values using `NULLIF`.
* **Views/Data Extraction:** Structuring queries specifically for dashboarding tools.

---

## 🔎 Key Analysis Breakdown

### 1. Global & Country-Level Stats
* **Infection Analysis:** Comparison of Total Cases vs. Total Deaths to calculate the *Death Percentage* (likelihood of dying if infected).
* **Population Impact:** Comparison of Total Cases vs. Population to determine the percentage of the population infected.
* **Drill-down:** Specific analysis on **Thailand** and **Cyprus** as case studies.

### 2. Regional Analysis (Continents)
* Identified countries with the **Highest Infection Rate** compared to their population.
* Ranked continents and countries by **Total Death Count**.

### 3. Vaccination Progress
* Performed a Join on `Covid_Deaths` and `Covid_Vaccinations` tables.
* Implemented a **Rolling Count** of new vaccinations using Window Functions to track progress over time per location.
* Used both **CTE** and **Temp Table** methods to calculate the *Percent of Population Vaccinated*.

---

## 📊 Visualization Preparation

The final section of the code includes optimized queries designed to export data for visualization tools (like Tableau or Power BI). These queries focus on:
1.  **Global Totals:** Overall cases, deaths, and death percentage.
2.  **Death Counts by Continent:** Excluding broad aggregates like 'World' or 'EU'.
3.  **Infection Maps:** Data showing the highest infection count and percent of population infected by country.
4.  **Time Series Data:** Infection progression over time.

---

## 📝 Usage

The queries are written in **T-SQL** (for Microsoft SQL Server).
To run this project:
1.  Import the `Covid_Deaths` and `Covid_Vaccinations` datasets into your SQL Server.
2.  Execute the queries sequentially to view the analysis.

---

## 👤 Author
**Chanyapon Trongjaroenchai**

*Disclaimer: Data used in this project is for educational and portfolio demonstration purposes.*
