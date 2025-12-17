# End-to-End Data-Driven Database Application

## Project Overview
This project is the final project for **CSCI-GA.2433 Database Systems**.
It implements an **end-to-end, data-driven database application** that integrates
an OLTP/ODS relational database, unstructured data processing, and a machine
learning–based analytics module to support business decision-making.

The system demonstrates how insights derived from unstructured data are
generated through a data-driven program module and integrated back into an
operational database to support a workflow-based application.

## End-to-End Architecture
The solution follows a layered architecture consisting of:
- Frontend (user interaction layer)
- Application layer (database connectivity and workflow orchestration)
- OLTP/ODS relational database
- Unstructured data processing pipeline
- Machine learning analytics module
- Insight integration back into the operational database

The architecture enables seamless data flow from user interaction to analytics
and back to the application layer.

## Technology Stack
- **Frontend:** Web-based user interface
- **Backend:** Application server with database connectivity
- **Database:** Relational OLTP/ODS database
- **Analytics / ML:** Data-driven module for processing unstructured data
- **ORM:** Object-Relational Mapping framework for database interaction

## End-to-End Workflow
1. A user interacts with the frontend and submits a request.
2. The application layer persists the request in the OLTP/ODS database.
3. Unstructured data associated with the request is processed by the
   data-driven analytics module.
4. A machine learning model generates insights (e.g., scores or recommendations).
5. The generated insights are written back to the OLTP/ODS database.
6. The application retrieves the updated data and presents results to the user.

## Data-Driven Program Module
The data-driven program module processes unstructured data and applies
machine learning techniques to generate actionable insights. The module
supports re-processing and retraining when new data becomes available,
ensuring that insights remain up to date.

## Repository Structure
- `frontend/` – User interface components
- `backend/` – Application logic and database connectivity
- `ml_module/` – Data-driven analytics and machine learning module
- `sql/` – Database schema and related scripts
- `diagrams/` – Architecture and workflow diagrams
- `screenshots/` – Application execution and result screenshots

## How to Run (Local)

### 1) Initialize the database (schema + seed)
```bash
python backend/init_db.py

