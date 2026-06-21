# Awaisjavid26-health-dashboard
An interactive Health Statistics Dashboard built with R and Shiny to analyze patient demographic and clinical data.
# Health Statistics Dashboard

An interactive, user-friendly **R Shiny** web application designed to explore and analyze clinical and demographic health data. This dashboard allows healthcare professionals, researchers, or analysts to dynamically filter and visualize patient statistics in real time.

## 🚀 Live Demo
You can interact with the live application here: 
👉 **[View Live Dashboard](https://awaisjavid.shinyapps.io/awaisjavid-health-dashboard/)**

---

## 📊 Key Features
* **Dynamic Data Filtering:** Filter the dataset seamlessly by Age Range, Gender, and specific Health Conditions/Diseases.
* **Real-Time Key Metrics:** Instant updates for core metrics including total patient count, average BMI, and average blood pressure via interactive value boxes.
* **Advanced Visualizations:** 
  * Disease distribution bar charts.
  * Gender breakdown via proportional pie charts.
  * Age distribution tracking using interactive histograms.
* **Interactive Data Table:** Full tabular view of the filtered healthcare data with built-in pagination and horizontal scrolling.

---

## 🛠️ Built With
* **R Programming Language**
* **Shiny & Shinydashboard** – For the reactive web structure and dashboard UI.
* **ggplot2** – For generating data visualizations.
* **DT (DataTables)** – For rendering the interactive data view.
* **dplyr** – For efficient data manipulation and filtering.

---

## 📂 Project Structure
* `app.R` – The unified script containing both the User Interface (UI) and Server logic.
