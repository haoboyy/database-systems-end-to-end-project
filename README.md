# Database Systems Final Project  
End-to-End Data-Driven Application

## Overview

This project implements an end-to-end data-driven application for the Database Systems final project.  
The system demonstrates how unstructured user requests are processed by a machine learning module, how insights are written back into an operational data store (ODS), and how the results are consumed by a workflow-based backend application.

The project includes:
- A relational OLTP / ODS schema
- Unstructured text ingestion
- A data-driven analytics / ML pipeline
- Insight persistence back into the database
- A backend API for workflow consumption

---

## Project Structure

```
backend/
  app.py               FastAPI backend application
  init_db.py           Database initialization script
  requirements.txt     Python dependencies

ml_module/
  run_pipeline.py      Data-driven ML pipeline

sql/
  schema.sql           Relational OLTP / ODS schema
  seed.sql             Seed data for demo

screenshots/
  01_db_init.png
  02_ml_pipeline.png
  03_recommendations_table.png
  04_api_response.png

diagrams/
  (architecture diagrams, optional)
```

---

## How to Run (Local)

### Step 1 – Initialize the database (schema and seed data)
```bash
python backend/init_db.py
```

### Step 2 – Install dependencies
```bash
python -m pip install -r backend/requirements.txt
```

### Step 3 – Run the data-driven analytics / ML pipeline
```bash
python ml_module/run_pipeline.py
```

### Step 4 – Start the backend API
```bash
python -m uvicorn backend.app:app --reload
```

### Step 5 – Verify the application

Health check endpoint:
```
http://127.0.0.1:8000/health
```

Recommendations endpoint:
```
http://127.0.0.1:8000/recommendations?request_id=1
```

---

## End-to-End Workflow Description

1. Unstructured request text is stored in the `requests` table.
2. Provider descriptions are stored in the `providers` table.
3. The data-driven program module applies TF-IDF and cosine similarity to compute match scores.
4. Generated insights are written back into the `recommendations` table in the ODS.
5. The backend API retrieves recommendations and returns them to the client.

---

## Evidence (Screenshots)

The following screenshots demonstrate successful end-to-end execution:

- `screenshots/01_db_init.png`  
  Database initialization completed successfully.

- `screenshots/02_ml_pipeline.png`  
  Data-driven ML pipeline executed and insights generated.

- `screenshots/03_recommendations_table.png`  
  Recommendations persisted back into the ODS database.

- `screenshots/04_api_response.png`  
  Backend API returns recommendations for a request.

---

## Notes

The application is executed locally.  
Screenshots are provided as evidence to demonstrate database updates, analytics execution, and workflow-based application behavior.
