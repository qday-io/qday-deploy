CREATE DATABASE prover_db;
\connect prover_db;

CREATE SCHEMA state;

CREATE TABLE state.nodes (hash BYTEA PRIMARY KEY, data BYTEA NOT NULL);
CREATE TABLE state.program (hash BYTEA PRIMARY KEY, data BYTEA NOT NULL);

-- Create gorp_migrations table for database migrations
CREATE TABLE IF NOT EXISTS public.gorp_migrations (
    id VARCHAR(255) PRIMARY KEY,
    applied_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE USER prover_user with password 'prover_pass';
ALTER DATABASE prover_db OWNER TO prover_user;
ALTER SCHEMA state OWNER TO prover_user;
ALTER SCHEMA public OWNER TO prover_user;
ALTER TABLE state.nodes OWNER TO prover_user;
ALTER TABLE state.program OWNER TO prover_user;
ALTER TABLE public.gorp_migrations OWNER TO prover_user;
ALTER USER prover_user SET SEARCH_PATH=state;