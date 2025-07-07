## MY-Uber-Drives-
# Uber Drives Analysis 

This project analyzes a dataset of Uber rides to extract meaningful business and personal travel insights. Using Power BI, key performance indicators (KPIs) such as top speed, most frequent travel purpose, average miles, and trip distributions are visualized to uncover travel behavior patterns.

---

## 📊 Dashboard Preview
<img width="498" alt="Uber Drives Dashboard" src="https://github.com/user-attachments/assets/5b06efed-2f2c-4841-ba5d-9b5bab814357" />


---

## 📁 Dataset Description

The dataset includes details of individual Uber rides with the following fields:

Start Date, End Date

Start Location, End Location

Category (Business / Personal)

Purpose (Meeting, Commute, etc.)

Miles (Distance)

Average Speed (Calculated)

---

## Objectives

Identify the most frequent travel purpose

Calculate the maximum average speed over all trips

Compare total miles vs number of trips per purpose

Visualize travel behavior by purpose, distance, and frequency

Enable interactive filtering for deeper insights

---
## Power BI Dashboard Features

Card Visuals:

Max Speed Over Period

Most Frequent Purpose

Bar Charts:

Average Miles by Purpose

Total Miles vs Number of Trips by Purpose

Table View:

Purpose-wise summary of total and count of miles

Interactivity:

Slicers and filters for dynamic analysis (optional)

## Key Calculations (DAX)

Average Speed = Miles / Duration

Max Speed = MAX([Average Speed])

Most Frequent Purpose = Extracted using TOPN on grouped trip count

## Insights

Most frequent purpose of travel: Meeting

Highest recorded average speed: 28.08 mph

Business-related purposes dominate mileage

A small number of purposes account for most of the travel

## Tools used

SQL

Power BI 

Excel
