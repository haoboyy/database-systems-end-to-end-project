"""
Data-Driven Program Module
Database Systems Final Project (Part IV)

This module processes unstructured request and provider text,
applies a machine learning–based similarity model, and writes
the resulting insights back to the OLTP/ODS database.
"""

import sqlite3
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

DB_PATH = "backend/app.db"


def run_pipeline():
    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # ------------------------------------------------------------------
    # Step 1: Retrieve the most recent request (unstructured input)
    # ------------------------------------------------------------------
    cursor.execute("""
        SELECT request_id, request_text
        FROM requests
        ORDER BY request_id DESC
        LIMIT 1
    """)
    request_row = cursor.fetchone()

    if not request_row:
        raise RuntimeError("No requests found in the database.")

    request_id, request_text = request_row

    # ------------------------------------------------------------------
    # Step 2: Retrieve provider data (entities to match against)
    # ------------------------------------------------------------------
    cursor.execute("""
        SELECT provider_id, provider_text
        FROM providers
    """)
    providers = cursor.fetchall()

    if not providers:
        raise RuntimeError("No providers found in the database.")

    provider_ids = [p[0] for p in providers]
    provider_texts = [p[1] for p in providers]

    # ------------------------------------------------------------------
    # Step 3: Apply ML-based text similarity (TF-IDF + cosine similarity)
    # ------------------------------------------------------------------
    corpus = [request_text] + provider_texts
    vectorizer = TfidfVectorizer(stop_words="english")
    vectors = vectorizer.fit_transform(corpus)

    similarities = cosine_similarity(vectors[0:1], vectors[1:]).flatten()

    # ------------------------------------------------------------------
    # Step 4: Persist insights back into the ODS
    # ------------------------------------------------------------------
    cursor.execute(
        "DELETE FROM recommendations WHERE request_id = ?",
        (request_id,)
    )

    recommendations = list(zip(provider_ids, similarities))
    recommendations.sort(key=lambda x: x[1], reverse=True)

    for provider_id, score in recommendations:
        cursor.execute("""
            INSERT INTO recommendations (request_id, provider_id, match_score)
            VALUES (?, ?, ?)
        """, (request_id, provider_id, float(score)))

    conn.commit()
    conn.close()

    print(f"Recommendations generated and stored for request_id={request_id}")


if __name__ == "__main__":
    run_pipeline()

