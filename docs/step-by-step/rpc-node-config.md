## RPC Node Config

RPC node config parameter details

---

- ### rpc1.node.config.toml

```toml
# Whether this node is a trusted sequencer (should be false for RPC nodes)
IsTrustedSequencer = false

[Log]
# Environment: "production" or "development"
Environment = "development"
# Log level: "debug", "info", "warn", "error"
Level = "debug"
# Log output destinations
Outputs = ["stderr"]

[State]
  [State.DB]
  # Database user for state DB
  User = "state_user"
  # Database password for state DB
  Password = "state_password"
  # Database name for state DB
  Name = "state_db"
  # Database host for state DB
  Host = "zkevm-state-db"
  # Database port for state DB
  Port = "5432"
  # Enable SQL query logging
  EnableLog = false
  # Maximum DB connections
  MaxConns = 200
  [State.Batch]
    [State.Batch.Constraints]
    # Maximum transactions per batch
    MaxTxsPerBatch = 300
    # Maximum batch size in bytes
    MaxBatchBytesSize = 120000
    # Maximum cumulative gas used per batch
    MaxCumulativeGasUsed = 30000000
    # Maximum number of Keccak hashes per batch
    MaxKeccakHashes = 2145
    # Maximum number of Poseidon hashes per batch
    MaxPoseidonHashes = 252357
    # Maximum number of Poseidon paddings per batch
    MaxPoseidonPaddings = 135191
    # Maximum number of memory aligns per batch
    MaxMemAligns = 236585
    # Maximum number of arithmetic operations per batch
    MaxArithmetics = 236585
    # Maximum number of binary operations per batch
    MaxBinaries = 473170
    # Maximum number of steps per batch
    MaxSteps = 7570538
    # Maximum number of SHA256 hashes per batch
    MaxSHA256Hashes = 1596

[Pool]
# Gas limit for free claim transactions
FreeClaimGasLimit = 1500000
# Interval to refresh blocked addresses
IntervalToRefreshBlockedAddresses = "5m"
# Interval to refresh gas prices
IntervalToRefreshGasPrices = "5s"
# Maximum transaction size in bytes
MaxTxBytesSize=100132
# Maximum transaction data size in bytes
MaxTxDataBytesSize=100000
# Default minimum allowed gas price (wei)
DefaultMinGasPriceAllowed = 1000000000
# Interval to update minimum allowed gas price
MinAllowedGasPriceInterval = "5m"
# Polling interval for minimum allowed gas price
PollMinAllowedGasPriceInterval = "15s"
# Account queue size
AccountQueue = 100000
# Global queue size
GlobalQueue = 5242880
  [Pool.EffectiveGasPrice]
    # Enable effective gas price calculation
    Enabled = false
    # L1 gas price factor
    L1GasPriceFactor = 0.25
    # Gas cost per byte
    ByteGasCost = 16
    # Gas cost per zero byte
    ZeroByteGasCost = 4
    # Net profit factor
    NetProfit = 1
    # Break-even factor
    BreakEvenFactor = 1.1
    # Final deviation percent
    FinalDeviationPct = 10
    # Gas price for ETH transfers
    EthTransferGasPrice = 0
    # L1 gas price factor for ETH transfers
    EthTransferL1GasPriceFactor = 0
    # L2 gas price suggester factor
    L2GasPriceSuggesterFactor = 0.5
  [Pool.DB]
  # Database user for pool DB
  User = "pool_user"
  # Database password for pool DB
  Password = "pool_password"
  # Database name for pool DB
  Name = "pool_db"
  # Database host for pool DB
  Host = "zkevm-pool-db"
  # Database port for pool DB
  Port = "5432"
  # Enable SQL query logging
  EnableLog = false
  # Maximum DB connections
  MaxConns = 200

[Etherman]
# L1 node RPC URL
URL = "http://190.92.213.101:8545"
# Fork ID chunk size
ForkIDChunkSize = 20000
# Enable multi gas provider
MultiGasProvider = false
  [Etherscan]
    # Etherscan API key (optional)
    ApiKey = ""

[RPC]
# Host for JSON-RPC server
Host = "0.0.0.0"
# Port for JSON-RPC server
Port = 8123
# Read timeout
ReadTimeout = "60s"
# Write timeout
WriteTimeout = "60s"
# Max requests per IP per second
MaxRequestsPerIPAndSecond = 5000
# URI of the sequencer node (leave empty for RPC node)
SequencerNodeURI = ""
# Enable batch requests
BatchRequestsEnabled = true
# Limit for batch requests
BatchRequestsLimit = 1000
# Enable polling for L2 suggested gas price
EnableL2SuggestedGasPricePolling = true
  [RPC.WebSockets]
    # Enable WebSocket server
    Enabled = true
    # WebSocket port
    Port = 8133

[Synchronizer]
# Synchronization interval
SyncInterval = "2s"
# Synchronization chunk size
SyncChunkSize = 10
# Trusted sequencer URL (leave empty to read from contract)
TrustedSequencerURL = ""
# L1 synchronization mode: "sequential" or "parallel"
L1SynchronizationMode = "parallel"
# Auto update genesis config if root mismatch
AutoUpdateGenesisConfig = true
# Path to genesis config file
GenesisConfigPath = "/app/genesis.json"
  [Synchronizer.L1ParallelSynchronization]
    # Max parallel clients
    MaxClients = 10
    # Max pending unprocessed blocks
    MaxPendingNoProcessedBlocks = 25
    # Period to request last block
    RequestLastBlockPeriod = "5s"
    # Timeout for requesting last block
    RequestLastBlockTimeout = "5s"
    # Max retries for requesting last block
    RequestLastBlockMaxRetries = 3
    # Statistics reporting period
    StatisticsPeriod = "5m"
    # Timeout for main loop
    TimeoutMainLoop = "5m"
    # Spacing between rollup info retries
    RollupInfoRetriesSpacing= "5s"
    # Fallback to sequential mode after sync
    FallbackToSequentialModeOnSynchronized = false
    [Synchronizer.L1ParallelSynchronization.PerformanceWarning]
      # Acceptable inactivity time
      AceptableInacctivityTime = "5s"
      # Apply warning after this many rollups
      ApplyAfterNumRollupReceived = 10

[L2GasPriceSuggester]
# Type of gas price suggester
Type = "default"
# Update period for gas price
UpdatePeriod = "10s"
# Gas price factor
Factor = 0.5
# Default gas price in wei
DefaultGasPriceWei = 1000000
# Max gas price in wei
MaxGasPriceWei = 0

[MTClient]
# Merkle tree client URI
URI  = "190.92.213.101:50061"

[Executor]
# Executor service URI
URI = "190.92.213.101:50071"
# Max gRPC message size
MaxGRPCMessageSize = 10000000000

[Metrics]
# Metrics server host
Host = "0.0.0.0"
# Metrics server port
Port = 9091
# Enable metrics
Enabled = true
# Profiling server host
ProfilingHost = "0.0.0.0"
# Profiling server port
ProfilingPort = 6060
# Enable profiling
ProfilingEnabled = false
```

---

- ### rpc1.prover.config.json

```jsonc
{
  // Whether to run the executor server
  "runExecutorServer": true,
  // Whether to run the executor client
  "runExecutorClient": false,
  // Whether to run the executor client in multithread mode
  "runExecutorClientMultithread": false,

  // Whether to run the HashDB server
  "runHashDBServer": true,
  // Whether to run HashDB test mode
  "runHashDBTest": false,

  // Whether to run the aggregator server
  "runAggregatorServer": false,
  // Whether to run the aggregator client
  "runAggregatorClient": false,
  // Whether to run the aggregator client in mock mode
  "runAggregatorClientMock": true,
  // Timeout for aggregator client mock (seconds)
  "aggregatorClientMockTimeout": 1,
  // Prover instance name
  "proverName": "test-prover",

  // File generation and processing options (all false for RPC node)
  "runFileGenBatchProof": false,
  "runFileGenAggregatedProof": false,
  "runFileGenFinalProof": false,
  "runFileProcessBatch": false,
  "runFileProcessBatchMultithread": false,

  // Test and script options (all false for RPC node)
  "runKeccakScriptGenerator": false,
  "runKeccakTest": false,
  "runStorageSMTest": false,
  "runBinarySMTest": false,
  "runMemAlignSMTest": false,
  "runSHA256Test": false,
  "runBlakeTest": false,

  // Parallel execution and cache options
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

  // Prover and executor server/client ports and hosts
  "proverServerPort": 50051,
  "proverServerMockPort": 50052,
  "proverServerMockTimeout": 10000000,
  "proverClientPort": 50051,
  "proverClientHost": "127.0.0.1",

  "executorServerPort": 50071,
  "executorROMLineTraces": false,
  "executorClientPort": 50071,
  "executorClientHost": "127.0.0.1",

  // HashDB server configuration
  "hashDBServerPort": 50061,
  "hashDBURL": "local",

  // Aggregator server/client configuration
  "aggregatorServerPort": 50081,
  "aggregatorClientPort": 50081,
  "aggregatorClientHost": "zkevm-aggregator",

  // Mapping and input/output files
  "mapConstPolsFile": false,
  "mapConstantsTreeFile": false,

  "inputFile": "input_executor_0.json",
  "inputFile2": "input_executor_1.json",

  "keccakScriptFile": "config/scripts/keccak_script.json",
  "storageRomFile": "config/scripts/storage_sm_rom.json",

  "outputPath": "output",

  // Database connection for prover
  "databaseURL": "postgresql://prover_user:prover_pass@zkevm-state-db:5432/prover_db",
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

> For most deployments, only a few fields (such as DB connection, RPC port, and L1/L2 URLs) need to be changed. Other fields can use the defaults unless you have special requirements.
