# Use Case and Workflow Documentation

This section documents the primary business use case and the corresponding workflow-based application process, aligned with the Part IV requirements.

## 1. Primary Use Case

**Use Case Name:** Data-Driven Provider Recommendation

**Actors**
- Client (end-user submitting a project request)
- System (workflow-based application and data-driven module)

**Goal**
Provide ranked service provider recommendations for a client’s project request based on structured metadata and unstructured text similarity.

**Preconditions**
- Provider profiles exist in the system
- The operational database schema is initialized
- The data-driven module is available to generate insights

**Postconditions**
- Ranked recommendations are persisted in the operational database
- Results are available to end-users through the application API

## 2. Use Case Flow

1. The client submits a project request containing structured attributes and unstructured description text.
2. The system stores the request in the operational database.
3. The data-driven module processes request and provider text using NLP techniques.
4. Similarity scores are computed and ranked.
5. Recommendation results are written back into the operational database.
6. The workflow application exposes recommendations via an API endpoint.

## 3. Workflow-Based Application Process

The workflow is orchestrated by the backend application and integrates database operations with analytics:

- **Ingestion:** insert request/provider data into relational tables
- **Processing:** execute the ML/NLP pipeline over unstructured text
- **Persistence:** store insights (scores and ranks) in the `recommendations` table
- **Consumption:** retrieve recommendations through the API

## 4. Workflow Diagram

![Workflow Diagram](../diagrams/workflow.png)

## 5. Database Interaction Points

- INSERT into `requests` and `providers`
- SELECT and JOIN during analytics processing
- INSERT into `recommendations`
- SELECT by `request_id` during API serving

This workflow demonstrates a complete end-to-end integration between a workflow-based application and a data-driven analytics module.
