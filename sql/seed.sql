-- Seed data for demo / screenshots

INSERT INTO providers (provider_name, provider_text) VALUES
('Provider A', 'I build full-stack web apps with React, Next.js, and PostgreSQL. I also design database schemas.'),
('Provider B', 'I specialize in data engineering, ETL pipelines, and analytics. Experienced with SQL optimization.'),
('Provider C', 'I focus on machine learning and NLP. I can build recommendation systems and text similarity models.');

INSERT INTO requests (user_id, request_text) VALUES
(1, 'Need a provider to build an end-to-end web app with a relational database and a recommendation feature based on text.');
