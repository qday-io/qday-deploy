#!/bin/bash

echo "Fixing database migrations for zkEVM nodes..."
echo "============================================="

# Function to fix database migrations
fix_db_migrations() {
    local db_name=$1
    local db_user=$2
    local db_password=$3
    local db_port=$4
    
    echo "Fixing migrations for $db_name on port $db_port..."
    
    # Create gorp_migrations table
    PGPASSWORD=$db_password psql -h localhost -p $db_port -U $db_user -d $db_name -c "
    CREATE TABLE IF NOT EXISTS public.gorp_migrations (
        id VARCHAR(255) PRIMARY KEY,
        applied_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
    );
    
    GRANT ALL PRIVILEGES ON TABLE public.gorp_migrations TO $db_user;
    GRANT USAGE ON SCHEMA public TO $db_user;
    GRANT CREATE ON SCHEMA public TO $db_user;
    " 2>/dev/null
    
    if [ $? -eq 0 ]; then
        echo "✅ Fixed migrations for $db_name"
    else
        echo "❌ Failed to fix migrations for $db_name"
    fi
}

# Check if databases are running
echo "Checking database status..."

# Fix state database (port 5432)
if docker ps | grep -q "zkevm-state-db"; then
    fix_db_migrations "state_db" "state_user" "state_password" "5432"
else
    echo "⚠️  State database not running"
fi

# Fix state database 2 (port 5438)
if docker ps | grep -q "zkevm-state-db-2"; then
    fix_db_migrations "state_db" "state_user" "state_password" "5438"
else
    echo "⚠️  State database 2 not running"
fi

# Fix pool database (port 5433)
if docker ps | grep -q "zkevm-pool-db"; then
    fix_db_migrations "pool_db" "pool_user" "pool_password" "5433"
else
    echo "⚠️  Pool database not running"
fi

# Fix pool database 2 (port 5439)
if docker ps | grep -q "zkevm-pool-db-2"; then
    fix_db_migrations "pool_db" "pool_user" "pool_password" "5439"
else
    echo "⚠️  Pool database 2 not running"
fi

# Fix event database (port 5435)
if docker ps | grep -q "zkevm-event-db"; then
    fix_db_migrations "event_db" "event_user" "event_password" "5435"
else
    echo "⚠️  Event database not running"
fi

# Fix event database 2 (port 5440)
if docker ps | grep -q "zkevm-event-db-2"; then
    fix_db_migrations "event_db" "event_user" "event_password" "5440"
else
    echo "⚠️  Event database 2 not running"
fi

echo ""
echo "Migration fix completed!"
echo ""
echo "If you still see migration errors, try:"
echo "1. Stop the RPC nodes: make stop-rpc-nodes"
echo "2. Clean the databases: make clean"
echo "3. Restart the RPC nodes: make rpc-nodes" 