from fastapi import FastAPI
import sqlite3

DB_PATH = "backend/app.db"

app = FastAPI(title="End-to-End DB Project API")

def get_conn():
    return sqlite3.connect(DB_PATH)

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/recommendations")
def recommendations(request_id: int):
    conn = get_conn()
    cur = conn.cursor()
    cur.execute("""
        SELECT r.request_id,
               p.provider_id,
               p.provider_name,
               rec.match_score,
               rec.created_at
        FROM recommendations rec
        JOIN requests r ON r.request_id = rec.request_id
        JOIN providers p ON p.provider_id = rec.provider_id
        WHERE r.request_id = ?
        ORDER BY rec.match_score DESC
        LIMIT 10;
    """, (request_id,))
    rows = cur.fetchall()
    conn.close()

    return [
        {
            "request_id": rid,
            "provider_id": pid,
            "provider_name": pname,
            "match_score": score,
            "created_at": created_at,
        }
        for (rid, pid, pname, score, created_at) in rows
    ]
