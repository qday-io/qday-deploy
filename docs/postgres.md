# PostgreSQL Replication on Docker Compose

## Master

```bash
$ mkdir -p ~/deploy/postgres/data
$ sudo chown -R 70:70 ~/deploy/postgres/data # 70 is the user id of postgres docker image
$ cd ~/deploy/postgres
$ vim docker-compose.yml
services:
  
  postgres:
    image: postgres:17-alpine
    container_name: postgres
    user: postgres
    restart: always
    ports:
      - "5432:5432"
    environment:
      POSTGRES_PASSWORD: master-password
      POSTGRES_HOST_AUTH_METHOD: "scram-sha-256\nhost replication all 0.0.0.0/0 md5"
      POSTGRES_INITDB_ARGS: "--auth-host=scram-sha-256"
    volumes:
      - ./data:/var/lib/postgresql/data
    command: |
      postgres 
      -c wal_level=replica 
      -c hot_standby=on 
      -c max_wal_senders=10 
      -c max_replication_slots=10 
      -c hot_standby_feedback=on
      -c max_connections=1000
$ docker compose up -d
$ docker compose logs -f
```

Create a replication user and slot.

```bash
$ docker exec -it postgres psql -U postgres
CREATE USER replicator WITH REPLICATION ENCRYPTED PASSWORD 'replicator-password';
SELECT PG_CREATE_PHYSICAL_REPLICATION_SLOT('replication_slot');
```

## Slave

```bash
$ mkdir -p ~/deploy/postgres/data
$ sudo chown -R 70:70 ~/deploy/postgres/data
$ cd ~/deploy/postgres
$ vim docker-compose.yml
services:
  
  postgres:
    image: postgres:17-alpine
    container_name: postgres
    user: postgres
    restart: always
    ports:
      - "5432:5432"
    environment:
      PGUSER: replicator
      PGPASSWORD: replicator-password
    extra_hosts:
      - "master:192.168.33.177"
    volumes:
      - ./data:/var/lib/postgresql/data
    command: |
      bash -c "
      if [ -f /var/lib/postgresql/data/PG_VERSION ]; then
          echo 'Data directory already exists, skip pg_basebackup...'
      else
          echo 'Data directory empty, do initial basebackup from master...'
          until pg_basebackup --pgdata=/var/lib/postgresql/data \
                              -R \
                              --slot=replication_slot \
                              --host=master \
                              --port=5432
          do
            echo 'Waiting for primary to connect...'
            sleep 1s
          done
          echo 'Base backup done.'
          echo 'max_connections = 1000' >> /var/lib/postgresql/data/postgresql.conf
          chmod 0700 /var/lib/postgresql/data
      fi
      echo 'Starting PostgreSQL...'
      exec postgres
      "
$ docker compose up -d
$ docker compose logs -f
```
## Test

- Master

```bash
$ docker exec -it postgres psql -U postgres
# Create a table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL 
);
# Insert data
INSERT INTO users (username) VALUES ('foo'), ('bar');

# Select data
postgres=# SELECT * FROM users;
 id | username
----+----------
  1 | foo
  2 | bar
(2 rows)
```

- Slave

```bash
$ docker exec -it postgres psql -U postgres

# List tables
postgres=# \dt
         List of relations
 Schema | Name  | Type  |  Owner
--------+-------+-------+----------
 public | users | table | postgres
(1 row)

# Select data
postgres=# SELECT * FROM users;
 id | username
----+----------
  1 | foo
  2 | bar
(2 rows)

# Try to insert data
postgres=# INSERT INTO users (username) VALUES ('baz');
ERROR:  cannot execute INSERT in a read-only transaction
```

## References

- [Docker Composeを使用したPostgreSQLのレプリケーション環境の構築](https://zenn.dev/kentama/articles/cab600567d888b)