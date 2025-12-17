-- ============================================================
-- OLTP / ODS Relational Schema
-- Database Systems Final Project (Part IV)
-- ============================================================

-- -------------------------
-- Requests (Unstructured Input)
-- -------------------------
CREATE TABLE IF NOT EXISTS requests (
    request_id      INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id         INTEGER,
    request_text    TEXT NOT NULL,
    created_at      TEXT DEFAULT (datetime('now'))
);

-- -------------------------
-- Providers (Entities to Match Against)
-- -------------------------
CREATE TABLE IF NOT EXISTS providers (
    provider_id     INTEGER PRIMARY KEY AUTOINCREMENT,
    provider_name   TEXT NOT NULL,
    provider_text   TEXT NOT NULL,
    created_at      TEXT DEFAULT (datetime('now'))
);

-- -------------------------
-- Recommendations (ML Insights Written Back to ODS)
-- -------------------------
CREATE TABLE IF NOT EXISTS recommendations (
    recommendation_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    request_id          INTEGER NOT NULL,
    provider_id         INTEGER NOT NULL,
    match_score         REAL NOT NULL,
    created_at          TEXT DEFAULT (datetime('now')),

    FOREIGN KEY (request_id) REFERENCES requests(request_id),
    FOREIGN KEY (provider_id) REFERENCES providers(provider_id)
);

-- -------------------------
-- Indexes for Query Optimization
-- -------------------------
CREATE INDEX IF NOT EXISTS idx_requests_created_at
    ON requests(created_at);

CREATE INDEX IF NOT EXISTS idx_recommendations_request
    ON recommendations(request_id);

CREATE INDEX IF NOT EXISTS idx_recommendations_provider
    ON recommendations(provider_id);

CREATE INDEX IF NOT EXISTS idx_recommendations_score
    ON recommendations(match_score);

