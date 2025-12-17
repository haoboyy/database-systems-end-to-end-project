# Implementation Mapping (Target Architecture vs. Course Demo)

This project was designed using a cloud-based target architecture (Part II/III) and implemented as a local, reproducible course demo (Part IV). The demo preserves the same end-to-end data flow and responsibilities, while replacing cloud services with lightweight local equivalents to ensure graders can run it easily.

## 1. Target Architecture (Part II/III)

The intended production-style architecture uses:
- User Interaction Layer: Client Web UI, Provider Web UI
- Application/API Layer: REST API Server
- Unstructured Data Lake: Azure Blob Storage / Azure Data Lake / Synapse
- AI/NLP Processing: Azure Machine Learning (feature extraction + model inference)
- Structured Data Store (OLTP/ODS): Azure SQL Database / MySQL (InnoDB)
- Analytics/Serving: recommendation service + dashboards/reports

## 2. Course Demo Implementation (Part IV)

To make the system runnable on any machine without cloud credentials, the Part IV implementation uses:
- A local Python-based backend (FastAPI) as the workflow application and API layer
- A local SQLite database as the OLTP/ODS store
- A local Python ML module (scikit-learn) to perform NLP feature extraction and similarity scoring
- SQL scripts and seed data to recreate the schema and run repeatable end-to-end demos

## 3. Service-by-Service Mapping

| Target / Cloud Component (Part II/III) | Course Demo Component (Part IV) | Why / Notes |
|---|---|---|
| Client/Provider Web UI | (Optional) local UI; API tested via browser/curl | UI is not required to demonstrate DB programming; API proves workflow consumption |
| REST API Server | FastAPI (`backend/app.py`) | Implements workflow endpoints and DB connectivity |
| Azure SQL / MySQL InnoDB (OLTP/ODS) | SQLite (`backend/app.db`) | Lightweight local ODS equivalent for repeatable grading |
| Blob / Data Lake / Synapse | SQLite tables + local execution | Unstructured text is stored and processed locally for reproducibility |
| Azure ML / Databricks | `ml_module/run_pipeline.py` (scikit-learn) | Performs NLP vectorization + scoring to generate insights |
| Analytics layer / Recommendation service | `recommendations` table + API endpoint | Insights are written back to ODS and consumed by the application |

## 4. End-to-End Data Flow Preserved

The demo preserves the same conceptual end-to-end loop:
1. Unstructured request/provider text is ingested and stored (requests/providers tables)
2. The data-driven module computes similarity scores (ML pipeline)
3. The resulting insights are persisted back into the operational store (recommendations table)
4. The workflow application exposes results to end-users via API (FastAPI endpoint)

This demonstrates the “end-to-end” integration required in Part IV while remaining fully runnable without external cloud dependencies.
