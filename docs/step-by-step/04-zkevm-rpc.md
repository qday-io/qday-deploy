# zkEVM JSON-RPC

> Host: qday-sg-01、qday-sg-02、abec-fn01-hz02、abec-fn02-hz03、abec00-ohio、testnet02-fr02

Clone the zkevm-deploy repository.

```bash
$ mkdir -p ~/dist
$ cd ~/dist
$ git clone https://github.com/qday-io/qday-zkevm-deploy.git
```

Create the directory for the zkevm-rpc.

```bash
$ mkdir -p ~/deploy/zkevm-rpc/data/{db,scripts,config}
$ cd ~/deploy/zkevm-rpc
$ cp ~/dist/qday-zkevm-deploy/data/config/test.genesis.config.json ./data/config/
$ rm -fr ~/dist/qday-zkevm-deploy
```

Create the database scripts for the zkevm-rpc.

```bash
$ vim ./data/scripts/init_prover_db.sql
CREATE DATABASE prover_db;
\connect prover_db;

CREATE SCHEMA state;

CREATE TABLE state.nodes (hash BYTEA PRIMARY KEY, data BYTEA NOT NULL);
CREATE TABLE state.program (hash BYTEA PRIMARY KEY, data BYTEA NOT NULL);

CREATE USER prover_user with password 'prover_pass';
ALTER DATABASE prover_db OWNER TO prover_user;
ALTER SCHEMA state OWNER TO prover_user;
ALTER SCHEMA public OWNER TO prover_user;
ALTER TABLE state.nodes OWNER TO prover_user;
ALTER TABLE state.program OWNER TO prover_user;
ALTER USER prover_user SET SEARCH_PATH=state;
```

Change the test.prover.config.json file.

```bash
$ vim data/config/test.prover.config.json
{
    "runProverServer": false,
    "runProverServerMock": false,
    "runProverClient": false,

    "runExecutorServer": true,
    "runExecutorClient": false,
    "runExecutorClientMultithread": false,

    "runHashDBServer": true,
    "runHashDBTest": false,

    "runAggregatorServer": false,
    "runAggregatorClient": false,

    "runFileGenProof": false,
    "runFileGenBatchProof": false,
    "runFileGenAggregatedProof": false,
    "runFileGenFinalProof": false,
    "runFileProcessBatch": false,
    "runFileProcessBatchMultithread": false,

    "runKeccakScriptGenerator": false,
    "runKeccakTest": false,
    "runStorageSMTest": false,
    "runBinarySMTest": false,
    "runMemAlignSMTest": false,
    "runSHA256Test": false,
    "runBlakeTest": false,

    "executeInParallel": true,
    "useMainExecGenerated": true,
    "saveRequestToFile": false,
    "saveInputToFile": false,
    "saveDbReadsToFile": false,
    "saveDbReadsToFileOnChange": false,
    "saveOutputToFile": false,
    "saveResponseToFile": false,
    "loadDBToMemCache": true,
    "opcodeTracer": false,
    "logRemoteDbReads": false,
    "logExecutorServerResponses": false,

    "proverServerPort": 50051,
    "proverServerMockPort": 50052,
    "proverServerMockTimeout": 10000000,
    "proverClientPort": 50051,
    "proverClientHost": "127.0.0.1",

    "executorServerPort": 50071,
    "executorROMLineTraces": false,
    "executorClientPort": 50071,
    "executorClientHost": "127.0.0.1",

    "hashDBServerPort": 50061,
    "hashDBURL": "local",

    "aggregatorServerPort": 50081,
    "aggregatorClientPort": 50081,
    "aggregatorClientHost": "zkevm-aggregator",

    "inputFile": "input_executor.json",
    "outputPath": "output",
    "cmPolsFile_disabled": "zkevm.commit",
    "cmPolsFileC12a_disabled": "zkevm.c12a.commit",
    "cmPolsFileRecursive1_disabled": "zkevm.recursive1.commit",
    "constPolsFile": "zkevm.const",
    "constPolsC12aFile": "zkevm.c12a.const",
    "constPolsRecursive1File": "zkevm.recursive1.const",
    "mapConstPolsFile": false,
    "constantsTreeFile": "zkevm.consttree",
    "constantsTreeC12aFile": "zkevm.c12a.consttree",
    "constantsTreeRecursive1File": "zkevm.recursive1.consttree",
    "mapConstantsTreeFile": false,
    "starkFile": "zkevm.prove.json",
    "starkZkIn": "zkevm.proof.zkin.json",
    "starkZkInC12a":"zkevm.c12a.zkin.proof.json",
    "starkFileRecursive1": "zkevm.recursive1.proof.json",
    "verifierFile": "zkevm.verifier.dat",
    "verifierFileRecursive1": "zkevm.recursive1.verifier.dat",
    "witnessFile_disabled": "zkevm.witness.wtns",
    "witnessFileRecursive1": "zkevm.recursive1.witness.wtns",
    "execC12aFile": "zkevm.c12a.exec",
    "execRecursive1File": "zkevm.recursive1.exec",
    "starkVerifierFile": "zkevm.g16.0001.zkey",
    "publicStarkFile": "zkevm.public.json",
    "publicFile": "public.json",
    "proofFile": "proof.json",
    "keccakScriptFile": "keccak_script.json",
    "keccakPolsFile_DISABLED": "keccak_pols.json",
    "keccakConnectionsFile": "keccak_connections.json",
    "starkInfoFile": "zkevm.starkinfo.json",
    "starkInfoC12aFile": "zkevm.c12a.starkinfo.json",
    "starkInfoRecursive1File": "zkevm.recursive1.starkinfo.json",
    "databaseURL": "postgresql://prover_user:prover_pass@zkevm-state-db:5432/prover_db",
    "dbNodesTableName": "state.nodes",
    "dbProgramTableName": "state.program",
    "dbAsyncWrite": false,
    "dbMultiWrite": true,
    "dbConnectionsPool": true,
    "dbNumberOfPoolConnections": 30,
    "dbMetrics": true,
    "dbClearCache": false,
    "dbGetTree": true,
    "dbReadOnly": false,
    "dbMTCacheSize": 8192,
    "dbProgramCacheSize": 1024,
    "cleanerPollingPeriod": 600,
    "requestsPersistence": 3600,
    "maxExecutorThreads": 20,
    "maxProverThreads": 8,
    "maxHashDBThreads": 8,
    "ECRecoverPrecalc": false,
    "ECRecoverPrecalcNThreads": 4,
    "stateManager": true,
    "useAssociativeCache" : false
}
```


Change test.node.config.toml file.

```bash
$ vim data/config/test.node.config.toml
[Log]
Environment = "development" # "production" or "development"
Level = "info"
Outputs = ["stderr"]

[State]
AccountQueue = 64
	[State.DB]
	User = "state_user"
	Password = "state_password"
	Name = "state_db"
	Host = "zkevm-state-db"
	Port = "5432"
	EnableLog = false	
	MaxConns = 200
	[State.Batch]
		[State.Batch.Constraints]
		MaxTxsPerBatch = 300
		MaxBatchBytesSize = 120000
		MaxCumulativeGasUsed = 30000000
		MaxKeccakHashes = 2145
		MaxPoseidonHashes = 252357
		MaxPoseidonPaddings = 135191
		MaxMemAligns = 236585
		MaxArithmetics = 236585
		MaxBinaries = 473170
		MaxSteps = 7570538

[Pool]
IntervalToRefreshBlockedAddresses = "5m"
IntervalToRefreshGasPrices = "5s"
MaxTxBytesSize=100132
MaxTxDataBytesSize=100000
DefaultMinGasPriceAllowed = 1000000000
MinAllowedGasPriceInterval = "5m"
PollMinAllowedGasPriceInterval = "15s"
	[Pool.DB]
	User = "pool_user"
	Password = "pool_password"
	Name = "pool_db"
	Host = "zkevm-pool-db"
	Port = "5432"
	EnableLog = false
	MaxConns = 200

[Etherman]
URL = "http://119.13.103.230:8545"
ForkIDChunkSize = 20000
MultiGasProvider = false
	[Etherman.Etherscan]
		ApiKey = ""

[RPC]
Host = "0.0.0.0"
Port = 8123
ReadTimeout = "60s"
WriteTimeout = "60s"
MaxRequestsPerIPAndSecond = 5000
BatchRequestsEnabled = true
BatchRequestsLimit = 500
SequencerNodeURI = ""
EnableL2SuggestedGasPricePolling = false
	[RPC.WebSockets]
		Enabled = true
		Port = 8133

[Synchronizer]
SyncInterval = "2s"
SyncChunkSize = 100

[MTClient]
URI = "zkevm-prover:50061"

[Executor]
URI = "zkevm-prover:50071"
MaxResourceExhaustedAttempts = 3
WaitOnResourceExhaustion = "1s"
MaxGRPCMessageSize = 100000000

[Metrics]
Host = "0.0.0.0"
Port = 9091
Enabled = false
ProfilingHost = "0.0.0.0"
ProfilingPort = 6060
ProfilingEnabled = false

[HashDB]
User = "prover_user"
Password = "prover_pass"
Name = "prover_db"
Host = "zkevm-state-db"
Port = "5432"
EnableLog = false
MaxConns = 200
```


```bash
$ vim docker-compose.yml
```

```yml
networks:
  default:
    name: zkevm-rpc

x-default-config: &default-config
  extra_hosts:
    - "zkevm-aggregator:159.138.82.123"
  logging:
    driver: "json-file"
    options:
      max-size: "100m"
      
services:

  zkevm-state-db:
    container_name: zkevm-state-db
    restart: unless-stopped
    image: postgres:17-alpine
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -d $${POSTGRES_DB} -U $${POSTGRES_USER}"]
      interval: 10s
      timeout: 5s
      retries: 5
    volumes:
      - ./data/scripts/init_prover_db.sql:/docker-entrypoint-initdb.d/init.sql
      - ./data/db/state:/var/lib/postgresql/data
    environment:
      - POSTGRES_USER=state_user
      - POSTGRES_PASSWORD=state_password
      - POSTGRES_DB=state_db
    command:
      - "postgres"
      - "-N"
      - "500"

  zkevm-pool-db:
    container_name: zkevm-pool-db
    restart: unless-stopped
    image: postgres:17-alpine
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -d $${POSTGRES_DB} -U $${POSTGRES_USER}"]
      interval: 10s
      timeout: 5s
      retries: 5
    volumes:
      - ./data/db/pool:/var/lib/postgresql/data
    environment:
      - POSTGRES_USER=pool_user
      - POSTGRES_PASSWORD=pool_password
      - POSTGRES_DB=pool_db
    command:
      - "postgres"
      - "-N"
      - "500"

  zkevm-json-rpc:
    image: ghcr.io/terry1ee/qday-zkevm-node:20250304
    container_name: zkevm-json-rpc
    restart: unless-stopped
    depends_on:
      zkevm-pool-db:
        condition: service_healthy
      zkevm-state-db:
        condition: service_healthy
      zkevm-sync:
        condition: service_started
    deploy:
      resources:
        limits:
          memory: 1G
        reservations:
          memory: 512M
    ports:
      - 8123:8123
      - 8133:8133
      - 9091:9091
    environment:
      - ZKEVM_NODE_ETHERMAN_URL=http://119.13.103.230:8545
      - ZKEVM_NODE_RPC_WEBSOCKETS_PORT=8133
    volumes:
      - ./data/config/test.node.config.toml:/app/config.toml
      - ./data/config/test.genesis.config.json:/app/genesis.json
    command:
      - "/bin/sh"
      - "-c"
      - "/app/b2-zkevm-node run --network custom --custom-network-file /app/genesis.json --cfg /app/config.toml --components rpc --http.api eth,net,debug,zkevm,txpool,web3"
    <<: *default-config

  zkevm-sync:
    container_name: zkevm-sync
    image: ghcr.io/terry1ee/qday-zkevm-node:20250304
    restart: unless-stopped
    ports:
      - 9092:9091
    depends_on:
      zkevm-state-db:
        condition: service_healthy
    deploy:
      resources:
        limits:
          memory: 1G
        reservations:
          memory: 512M
    environment:
      - ZKEVM_NODE_ETHERMAN_URL=http://119.13.103.230:8545
    volumes:
      - ./data/config/test.node.config.toml:/app/config.toml
      - ./data/config/test.genesis.config.json:/app/genesis.json
    command:
      - "/bin/sh"
      - "-c"
      - "/app/b2-zkevm-node run --network custom --custom-network-file /app/genesis.json --cfg /app/config.toml --components synchronizer"
    <<: *default-config

  zkevm-prover:
    container_name: zkevm-prover
    image: ghcr.io/abelianl2/abe-zkevm-prover:latest
    restart: always
    depends_on:
      zkevm-state-db:
        condition: service_healthy
    ports:
      - 50061:50061
      - 50071:50071
    volumes:
      - ./data/config/test.prover.config.json:/usr/src/app/config.json
    command:
      - -c
      - /usr/src/app/config.json
    <<: *default-config
```

Start services.

```bash
$ docker compose up -d zkevm-state-db zkevm-pool-db
$ docker compose up -d zkevm-prover
$ docker compose up -d zkevm-sync
$ docker compose up -d zkevm-json-rpc
```

URLs

- http://localhost:8123

Retrieve the latest block height using the curl command.

```bash
curl -X POST http://localhost:8123 \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0", "method":"eth_blockNumber", "params":[], "id":1}'
```