# zkEVM Prover

> Host: abec-fn00-hz01(116.202.169.210)

Create the directory for the prover.

```bash
$ mkdir -p ~/deploy/zkevm-prover/data/config
$ cd ~/deploy/zkevm-prover
```

Create the config file.

```bash
$ vim ./data/config/test.prover.config.json
```

```json
{
  "runExecutorServer": true,
  "runExecutorClient": false,
  "runExecutorClientMultithread": false,

  "runHashDBServer": true,
  "runHashDBTest": false,

  "runAggregatorServer": false,
  "runAggregatorClient": false,
  "runAggregatorClientMock": true,
  "aggregatorClientMockTimeout": 1,
  "proverName": "test-prover",

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
  "saveOutputToFile": true,
  "saveProofToFile": true,
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

  "mapConstPolsFile": false,
  "mapConstantsTreeFile": false,

  "inputFile": "input_executor_0.json",
  "inputFile2": "input_executor_1.json",

  "keccakScriptFile": "config/scripts/keccak_script.json",
  "storageRomFile": "config/scripts/storage_sm_rom.json",

  "outputPath": "output",

  "databaseURL": "postgresql://prover_user:hpt4CjGqocp01xRI@db:5432/prover_db",
  "dbNodesTableName": "state.nodes",
  "dbProgramTableName": "state.program",
  "dbMultiWrite": true,
  "dbFlushInParallel": false,
  "dbMTCacheSize": 1024,
  "dbProgramCacheSize": 512,
  "dbNumberOfPoolConnections": 290,
  "dbGetTree": true,
  "cleanerPollingPeriod": 600,
  "requestsPersistence": 3600,
  "maxExecutorThreads": 200,
  "maxProverThreads": 80,
  "maxHashDBThreads": 80,
  "ECRecoverPrecalc": false,
  "ECRecoverPrecalcNThreads": 4,
  "stateManager": true,
  "useAssociativeCache" : false
}
```

Create the docker-compose file.

```bash
$ vim docker-compose.yml
services:

  zkevm-prover:
    container_name: zkevm-prover
    image: ghcr.io/abelianl2/abe-zkevm-prover:latest
    ports:
      - 50061:50061
      - 50071:50071
    extra_hosts:
      - "db:119.13.103.230"
      - "zkevm-aggregator:159.138.82.123"
    volumes:
      - ./data/config/test.prover.config.json:/usr/src/app/config.json
    command:
      - -c
      - /usr/src/app/config.json
    logging:
      driver: "json-file"
      options:
        max-size: "100m"
```

Run the prover.

```bash
$ docker compose up -d
```

Check the logs.

```bash
$ docker compose logs -f
```