# Reference Architecture (RA)

This section summarizes the end-to-end reference architecture for the project, spanning the business, application, DIKW, and infrastructure domains.

## 1. Business Domain

**Goal:** match clients’ project requests to suitable service providers using data-driven insights.

**Primary actors**
- Client: creates a project request and consumes recommended providers
- Provider: maintains profile/skills and can respond to requests (future extension)

**Core business capabilities**
- Capture structured project/request metadata (budget, timestamps, identifiers)
- Capture unstructured text (project description, provider bio/skills text)
- Generate ranked recommendations (insights) using an ML/NLP module
- Persist insights back into the operational store (ODS/OLTP) for downstream consumption

## 2. Application Domain

**Workflow-based application**
- A backend API orchestrates the workflow:
  1) create/ingest request + provider data
  2) trigger or run the data-driven module
  3) write recommendations back to the operational database
  4) expose results via an API endpoint

**Key application modules**
- API Layer (FastAPI): workflow orchestration + database connectivity
- Data-Driven Module (Python ML pipeline): similarity scoring over unstructured text
- Persistence Layer (SQLite / ODS): stores requests, providers, recommendations

## 3. DIKW Domain

- **Data:** raw unstructured text (request/provider) + structured identifiers and timestamps
- **Information:** normalized records in relational tables; joinable entities (request_id, provider_id)
- **Knowledge:** computed similarity scores and ranked recommendations stored in `recommendations`
- **Wisdom:** actionable decision support (which providers to contact first) exposed to end-users via API

## 4. Infrastructure Domain

**Course demo implementation (local)**
- SQLite database (`backend/app.db`) acts as the OLTP/ODS store
- Python + scikit-learn runs the ML/NLP module locally
- FastAPI provides the workflow API

**Target architecture (cloud, Part II/III)**
- Azure Data Lake / Blob for unstructured storage
- Azure ML/Databricks for feature extraction and model execution
- Azure SQL / MySQL InnoDB for operational data store
- Synapse/analytics services for reporting and dashboards

## 5. Reference Architecture Diagram

![Reference Architecture](../diagrams/reference_architecture.png)
