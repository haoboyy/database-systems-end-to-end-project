# Query Optimization and Physical Design Rationale

This section summarizes query patterns in the workflow-based application and the corresponding physical design decisions. The Part IV demo runs locally (SQLite) for reproducibility, while Part III documents the target production physical design (MySQL/InnoDB).

## 1. Key Query Patterns

### Q1. Retrieve recommendations for a request (serving)
**Purpose:** return ranked providers for a given `request_id`.

Representative query pattern:
- Filter by `request_id`
- Order by `match_score` (descending)
- Join provider metadata if needed

### Q2. Generate recommendations (analytics pipeline)
**Purpose:** read request/provider text, compute similarity, and persist results.

Representative access pattern:
- Scan/select request text by `request_id`
- Scan/select provider text (all or filtered)
- Insert multiple rows into `recommendations`

## 2. Indexing Strategy

### Recommendations table
**Index:** `(request_id)`  
**Reason:** serving queries filter by request_id; this reduces lookup cost.

**Index:** `(request_id, match_score)` (target / production)  
**Reason:** supports “filter then rank” efficiently; enables fast top-k retrieval.

### Providers table
**Index:** `(provider_id)` (primary key)  
**Reason:** join and lookups are key-based.

### Requests table
**Index:** `(request_id)` (primary key)  
**Reason:** key-based retrieval for pipeline execution and serving.

## 3. Normalization vs. Performance Tradeoffs

The logical design follows 3NF/BCNF to reduce redundancy and improve integrity.  
For serving performance (especially at scale), a production system may introduce:
- denormalized summary fields
- precomputed top-k recommendation cache
- materialized aggregates

These are documented in Part III as target physical design considerations.

## 4. Partitioning and Precomputation (Target Design, Part III)

In the target MySQL/InnoDB design, scalability improvements can include:
- partitioning large fact tables by time or request_id ranges
- indexing strategies aligned with serving workload
- precomputed “top recommendations per request” tables for fast retrieval

The Part IV demo focuses on demonstrating correct end-to-end database programming and integration; performance-oriented design is addressed in the Part III target architecture and is conceptually preserved.

## 5. Summary

The end-to-end workflow is optimized around the primary serving query:
“get ranked recommendations for request_id”, supported by appropriate indexing and a clear separation between normalized storage and analytics-generated insights.
