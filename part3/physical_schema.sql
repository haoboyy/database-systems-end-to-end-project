-- ============================================================
-- EasyPair Platform - Physical Database Schema (MySQL / InnoDB)
-- ============================================================

CREATE DATABASE IF NOT EXISTS easypair;
USE easypair;

-- =======================
-- 1. Users (Clients & Providers)
-- =======================
CREATE TABLE Users (
    user_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(200) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('client','provider') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- =======================
-- 2. Projects (Posted by Clients)
-- =======================
CREATE TABLE Projects (
    project_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    client_id BIGINT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    category VARCHAR(100),
    budget_min DECIMAL(10,2),
    budget_max DECIMAL(10,2),
    status ENUM('open','in_progress','completed') NOT NULL DEFAULT 'open',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (client_id) REFERENCES Users(user_id)
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- Index for browsing & filtering
CREATE INDEX idx_projects_status_created ON Projects(status, created_at);

-- =======================
-- 3. Proposals (Submitted by Providers)
-- =======================
CREATE TABLE Proposals (
    proposal_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    project_id BIGINT NOT NULL,
    provider_id BIGINT NOT NULL,
    proposed_amount DECIMAL(10,2),
    message TEXT,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE,
    FOREIGN KEY (provider_id) REFERENCES Users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Faster lookup for project → proposals
CREATE INDEX idx_proposals_project ON Proposals(project_id);

-- =======================
-- 4. Contracts (Accepted Proposals)
-- =======================
CREATE TABLE Contracts (
    contract_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    proposal_id BIGINT NOT NULL,
    project_id BIGINT NOT NULL,
    provider_id BIGINT NOT NULL,
    client_id BIGINT NOT NULL,
    status ENUM('active','completed','cancelled') DEFAULT 'active',
    start_date DATE,
    end_date DATE,

    FOREIGN KEY (proposal_id) REFERENCES Proposals(proposal_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id),
    FOREIGN KEY (provider_id) REFERENCES Users(user_id),
    FOREIGN KEY (client_id) REFERENCES Users(user_id)
) ENGINE=InnoDB;

-- Optional: LIST partitioning by status (from your report)
-- (MySQL only supports partitioning on integer or certain column types)
-- Here is a conceptual example:
-- ALTER TABLE Contracts
-- PARTITION BY LIST COLUMNS(status) (
--     PARTITION p_active VALUES IN ('active'),
--     PARTITION p_completed VALUES IN ('completed'),
--     PARTITION p_cancelled VALUES IN ('cancelled')
-- );

-- =======================
-- 5. Messages (Project Communication)
-- =======================
CREATE TABLE Messages (
    message_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    project_id BIGINT NOT NULL,
    sender_id BIGINT NOT NULL,
    message_text TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (project_id) REFERENCES Projects(project_id) ON DELETE CASCADE,
    FOREIGN KEY (sender_id) REFERENCES Users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Index to load chat quickly
CREATE INDEX idx_messages_project_sent ON Messages(project_id, sent_at);

-- =======================
-- 6. Reviews (Client → Provider)
-- =======================
CREATE TABLE Reviews (
    review_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    contract_id BIGINT NOT NULL,
    reviewer_id BIGINT NOT NULL,
    provider_id BIGINT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (contract_id) REFERENCES Contracts(contract_id),
    FOREIGN KEY (reviewer_id) REFERENCES Users(user_id),
    FOREIGN KEY (provider_id) REFERENCES Users(user_id)
) ENGINE=InnoDB;

-- =======================
-- 7. Materialized Summary Tables (for analytics)
-- =======================

CREATE TABLE Provider_Avg_Rating (
    provider_id BIGINT PRIMARY KEY,
    avg_rating DECIMAL(3,2),
    review_count INT,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (provider_id) REFERENCES Users(user_id)
) ENGINE=InnoDB;

CREATE TABLE Project_Bid_Counts (
    project_id BIGINT PRIMARY KEY,
    bid_count INT,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
) ENGINE=InnoDB;

-- Done
