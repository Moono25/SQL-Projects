# SQL-Projects
Built a Data warehouse with SQL Server, and it includes ETL processes, data modelling and analytics.
# SQL Data Warehouse Project

> **Project Type:** Data Warehouse / ETL / Data Engineering / SQL / Data Modelling

---

## 1. Project Overview

### Background

[Briefly explain the project and the problem the warehouse is designed to address.]

### Approach

[Explain the overall approach: CRM and ERP source data → Bronze → Silver → Gold → analytical data model.]

### Outcome

[Explain what was produced: a structured SQL Server data warehouse with cleaned, integrated and analytics-ready data.]

### Project Attribution

[Briefly state that this is a learning/follow-along implementation based on the Data With Baraa SQL Data Warehouse project, with appropriate attribution.]

---

## 2. Objectives

- Build a SQL Server data warehouse using CRM and ERP source data.
- Ingest source data into a Bronze layer.
- Clean, standardize and transform data through the Silver layer.
- Develop a business-ready Gold layer.
- Integrate data from the CRM and ERP source systems.
- Develop a dimensional/star-schema data model.
- Implement data-quality checks to validate the warehouse.
- Document the warehouse architecture, data flow and data model.

---

## 3. Project Scope & Tools

### Scope

| Dimension | Details |
|---|---|
| **In Scope** | CRM and ERP sales/customer/product data; warehouse construction; ETL; data cleaning; transformation; modelling; quality checks |
| **Out of Scope** | [Anything demonstrably outside the project] |
| **Source Systems** | CRM and ERP |
| **Data Format** | CSV |
| **Database** | SQL Server |
| **Architecture** | Bronze → Silver → Gold |
| **Final Model** | Dimensional / Star Schema |

### Tools & Technologies

| Category | Tool(s) Used |
|---|---|
| Database | SQL Server |
| Query Language | T-SQL |
| Data Ingestion | `BULK INSERT` |
| ETL | SQL stored procedures |
| Data Modelling | SQL / Draw.io |
| Documentation | Markdown |
| Version Control | Git / GitHub |

---

## 4. Repository Structure

```text
[project-root]/
│
├── datasets/
│   ├── source_crm/
│   └── source_erp/
│
├── docs/
│   ├── data_architecture/
│   ├── data_flow/
│   ├── data_integration/
│   ├── data_model/
│   ├── ETL/
│   ├── data_catalog.md
│   ├── naming_conventions.md
│   └── project_notes/
│
├── scripts/
│   ├── Create_Database.sql
│   ├── Bronze/
│   ├── Silver/
│   └── Gold/
│
├── tests/
│   ├── Gold_Layer_Quality_Checks.sql
│   └── Silver_Layer_Quality_Checks.sql
│
└── README.md
```

> **Note:** The exact final folder/file names will be aligned with the repository once we finish organizing the GitHub version.

---

## 5. Data Workflow

### Workflow

```text
CRM CSV ──┐
          ├──> Bronze ──> Silver ──> Gold ──> Analytics-Ready Model
ERP CSV ──┘
```

### 1. Source

CRM and ERP datasets provided as CSV files.

### 2. Ingestion

Source files are loaded into the Bronze layer using SQL Server `BULK INSERT`.

### 3. Bronze Layer

[Describe the raw/staging layer and its purpose.]

### 4. Silver Layer

[Describe cleaning, standardization, validation and transformation performed on the source data.]

### 5. Gold Layer

[Describe the business-ready dimensional model.]

### 6. Output

[Describe the resulting customer, product and sales structures available for analytical use.]

### Architecture Diagram

[Insert existing data architecture diagram.]

### Data Flow Diagram

[Insert existing data flow diagram.]

### ETL Diagram

[Insert existing ETL diagram.]

---

## 6. Data Model & Schema

### Bronze Layer

Describe the CRM and ERP source tables loaded into the raw layer.

### Silver Layer

Describe the cleaned and standardized versions of the source tables.

### Gold Layer

#### `Gold.DM_Customers`

| Field | Description |
|---|---|
| Customer_Key | Warehouse/customer surrogate key |
| Customer_ID | Customer identifier |
| Customer_Number | Customer business identifier |
| First_Name | Customer first name |
| Last_Name | Customer last name |
| Country | Customer country |
| Marital_Status | Customer marital status |
| Gender | Customer gender |
| Birth_Date | Customer birth date |
| Create_Date | Customer record creation date |

#### `Gold.DM_Products`

[Document the product dimension fields.]

#### `Gold.Fact_Sales`

[Document the sales fact fields.]

### Relationships

[Explain how Fact Sales connects to the Customer and Product dimensions.]

---

## 7. ERD — Entity Relationship Diagram

[Insert the existing data-model / ERD diagram.]

### Model Explanation

[Briefly explain the fact and dimension relationships and why the model supports analytical querying.]

---

## 8. Data Quality & Validation

### Silver Layer Checks

- Null and duplicate key checks
- Unwanted whitespace
- Standardization checks
- Invalid product costs
- Invalid date ranges
- Invalid sales dates
- Sales/quantity/price consistency
- Birth-date validation
- Country standardization
- Category-field validation

### Gold Layer Checks

- Customer-key uniqueness
- Product-key uniqueness
- Fact-to-dimension referential integrity
- Validation of relationships within the analytical model

---

## 9. Key Outcomes

[Describe the tangible outputs of the warehouse implementation.]

Examples of outcomes to document:

- Integrated CRM and ERP data
- Cleaned and standardized source data
- Structured Bronze/Silver/Gold architecture
- Business-ready customer dimension
- Business-ready product dimension
- Sales fact structure
- Validated relationships between dimensions and facts

---

## 10. Assumptions & Limitations

- [Document assumptions contained in the source/project.]
- The project uses the provided CRM and ERP datasets.
- The warehouse represents the available project data rather than a live production environment.
- Historical-data requirements and real production orchestration are outside the demonstrated scope, where applicable.
- This is a learning/follow-along implementation rather than an independently commissioned production warehouse.

---

## 11. Future Enhancements

- Introduce automated orchestration for ETL execution.
- Add more comprehensive automated data-quality testing.
- Implement monitoring and logging beyond the current procedures.
- Add incremental loading rather than relying solely on full refreshes.
- Introduce historical tracking where business requirements justify it.
- Connect the warehouse to a BI tool for reporting.

---

## 12. Deliverables

- SQL Server database and schemas
- Bronze-layer DDL and loading procedure
- Silver-layer DDL and transformation procedure
- Gold-layer analytical model
- Data-quality test scripts
- Data architecture documentation
- Data-flow documentation
- ETL documentation
- Data model / ERD
- Data catalogue
- Naming conventions documentation

---

## 13. Author

**Mapenzi Moono**

[GitHub profile / LinkedIn / relevant portfolio links]

---

## Attribution

This project was completed as a learning/follow-along implementation based on educational material from **Data With Baraa**. The original project, architecture and learning resources should be credited accordingly.
