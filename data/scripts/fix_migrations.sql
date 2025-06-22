-- Fix for gorp_migrations table missing error
-- This script should be run on all databases that zkEVM nodes connect to

-- Create gorp_migrations table if it doesn't exist
CREATE TABLE IF NOT EXISTS public.gorp_migrations (
    id VARCHAR(255) PRIMARY KEY,
    applied_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Grant permissions to all relevant users
GRANT ALL PRIVILEGES ON TABLE public.gorp_migrations TO state_user;
GRANT ALL PRIVILEGES ON TABLE public.gorp_migrations TO pool_user;
GRANT ALL PRIVILEGES ON TABLE public.gorp_migrations TO event_user;
GRANT ALL PRIVILEGES ON TABLE public.gorp_migrations TO prover_user;

-- Create sequence for gorp_migrations if needed
CREATE SEQUENCE IF NOT EXISTS public.gorp_migrations_id_seq;
GRANT USAGE, SELECT ON SEQUENCE public.gorp_migrations_id_seq TO state_user;
GRANT USAGE, SELECT ON SEQUENCE public.gorp_migrations_id_seq TO pool_user;
GRANT USAGE, SELECT ON SEQUENCE public.gorp_migrations_id_seq TO event_user;
GRANT USAGE, SELECT ON SEQUENCE public.gorp_migrations_id_seq TO prover_user;

-- Ensure public schema permissions
GRANT USAGE ON SCHEMA public TO state_user;
GRANT USAGE ON SCHEMA public TO pool_user;
GRANT USAGE ON SCHEMA public TO event_user;
GRANT USAGE ON SCHEMA public TO prover_user;

-- Grant create permissions on public schema
GRANT CREATE ON SCHEMA public TO state_user;
GRANT CREATE ON SCHEMA public TO pool_user;
GRANT CREATE ON SCHEMA public TO event_user;
GRANT CREATE ON SCHEMA public TO prover_user; 