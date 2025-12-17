# Database Systems Final Project

## End-to-End Data-Driven Database Application

---

## Overview

This project is the final project for **CSCI-GA.2433 Database Systems** at **New York University (Courant Institute of Mathematical Sciences)**.

It implements an **end-to-end, data-driven database application** that integrates:

- A relational **OLTP / ODS database**
- **Unstructured data ingestion**
- A **machine learning–based analytics pipeline**
- Integration of analytics results back into the operational database
- A workflow-based backend API for consumption

The project demonstrates how insights derived from unstructured data can be processed by a data-driven program module and written back into an operational database to support business decision-making.

---

## End-to-End Architecture

The solution follows a layered, end-to-end architecture:

- **User Interaction Layer** (Client / Provider UI)
- **Application / API Layer** (workflow orchestration)
- **OLTP / ODS Relational Database**
- **Unstructured Data Processing Pipeline**
- **Machine Learning Analytics Module**
- **Insight Integration back into the Operational Database**

This architecture enables seamless data flow from user interaction to analytics and back to the application layer.

Architecture diagrams and workflow illustrations are provided in the `diagrams/` directory.

---

## Technology Stack

- **Frontend:** Web-based user interface (conceptual)
- **Backend:** Python + FastAPI
- **Database:** SQLite (local OLTP/ODS demo)
- **Analytics / ML:** scikit-learn (TF-IDF + cosine similarity)
- **API Server:** Uvicorn
- **ORM / DB Access:** Direct SQL (lightweight demo)

> Note: Cloud-based components (Azure Data Lake, Databricks, Synapse, Azure ML)
> described in Parts I–III are implemented here as a **local runnable prototype**
> to demonstrate equivalent end-to-end behavior.

---

## End-to-End Workflow

1. A user submits a project request.
2. The application layer persists the request in the OLTP/ODS database.
3. Unstructured request and provider text is processed by the data-driven ML module.
4. A machine learning model computes similarity scores and recommendations.
5. Generated insights are written back into the OLTP/ODS database.
6. The backend API retrieves and exposes the enriched data to the application layer.

---

## Repository Structure

```
backend/
  app.py              FastAPI backend application
  init_db.py          Database initialization script
  requirements.txt    Python dependencies

ml_module/
  run_pipeline.py     Data-driven ML pipeline

sql/
  schema.sql          OLTP / ODS schema
  seed.sql            Seed data

diagrams/
  reference_architecture.png
  workflow.png

screenshots/
  01_db_init.png
  02_ml_pipeline.png
  03_recommendations_table.png
  04_api_response.png

docs/
  implementation_mapping.md
  reference_architecture.md
  data_governance_dikw.md
```

---

## How to Run (Local End-to-End Demo)

### Prerequisites

- Python 3.10+
- Git

---

### Step 1: Clone the Repository

```bash
git clone https://github.com/haoboyy/database-systems-end-to-end-project.git
cd database-systems-end-to-end-project
```

---

### Step 2: Install Dependencies

```bash
python -m pip install -r backend/requirements.txt
```

---

### Step 3: Initialize the Database

```bash
python backend/init_db.py
```

---

### Step 4: Run the Data-Driven ML Pipeline

```bash
python ml_module/run_pipeline.py
```

---

### Step 5: Start the Backend API Server

```bash
python -m uvicorn backend.app:app --reload
```

The API server will be available at:

```
http://127.0.0.1:8000
```

---

### Step 6: Verify End-to-End Execution

Screenshots demonstrating successful execution are available in `screenshots/`.

---

## Author

**Haobo Yuan**  
NYU Courant Institute of Mathematical Sciences  
CSCI-GA.2433 Database Systems
