# zkEVM

> Host: qday-sg-03(159.138.82.123)

Clone the zkevm-deploy repository.

```bash
$ mkdir -p ~/dist
$ cd ~/dist
$ git clone https://github.com/qday-io/qday-zkevm-deploy.git
```

Create the directory for the zkevm.

```bash
$ mkdir -p ~/deploy/zkevm/data/config
$ cd ~/deploy/zkevm
$ cp -r ~/dist/qday-zkevm-deploy/data/keystore ./data/
$ cp ~/dist/qday-zkevm-deploy/data/config/test.genesis.config.json ./data/config/
$ cp ~/dist/qday-zkevm-deploy/data/config/test.node.config.toml ./data/config/
$ cp ~/dist/qday-zkevm-deploy/docker-compose.yml ./
$ rm -fr ~/dist/qday-zkevm-deploy
```

```bash
$ vim ./data/config/test.node.config.toml
```

> Change the database information and L1 RPC address.

```toml
IsTrustedSequencer = true

[Log]
Environment = "development" # "production" or "development"
Level = "debug"
Outputs = ["stderr"]

[State]
	[State.DB]
	User = "state_user"
	Password = "LEzCfmbigYi1tgpG"
	Name = "state_db"
	Host = "db"
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
		MaxSHA256Hashes = 1596

[Pool]
FreeClaimGasLimit = 1500000
IntervalToRefreshBlockedAddresses = "5m"
IntervalToRefreshGasPrices = "5s"
MaxTxBytesSize=100132
MaxTxDataBytesSize=100000
DefaultMinGasPriceAllowed = 1000000000
MinAllowedGasPriceInterval = "5m"
PollMinAllowedGasPriceInterval = "15s"
AccountQueue = 100000
GlobalQueue = 5242880
	[Pool.EffectiveGasPrice]
		Enabled = false
		L1GasPriceFactor = 0.25
		ByteGasCost = 16
		ZeroByteGasCost = 4
		NetProfit = 1
	    BreakEvenFactor = 1.1
		FinalDeviationPct = 10
		EthTransferGasPrice = 0
		EthTransferL1GasPriceFactor = 0
		L2GasPriceSuggesterFactor = 0.5
	[Pool.DB]
	User = "pool_user"
	Password = "2Ra0IEJ1Q54PVre0"
	Name = "pool_db"
	Host = "db"
	Port = "5432"
	EnableLog = false
	MaxConns = 200

[Etherman]
URL = "http://119.13.103.230:8545"
ForkIDChunkSize = 20000
MultiGasProvider = false
	[Etherscan]
		ApiKey = ""

[RPC]
Host = "0.0.0.0"
Port = 8123
ReadTimeout = "60s"
WriteTimeout = "60s"
MaxRequestsPerIPAndSecond = 5000
SequencerNodeURI = ""
BatchRequestsEnabled = true
BatchRequestsLimit = 1000
EnableL2SuggestedGasPricePolling = true
	[RPC.WebSockets]
		Enabled = true
		Port = 8133

[Synchronizer]
SyncInterval = "2s"
SyncChunkSize = 10
TrustedSequencerURL = "" # If it is empty or not specified, then the value is read from the smc.
L1SynchronizationMode = "parallel" # "sequential" or "parallel"
	[Synchronizer.L1ParallelSynchronization]
		MaxClients = 10
		MaxPendingNoProcessedBlocks = 25
		RequestLastBlockPeriod = "5s"
		RequestLastBlockTimeout = "5s"
		RequestLastBlockMaxRetries = 3
		StatisticsPeriod = "5m"
		TimeoutMainLoop = "5m"
		RollupInfoRetriesSpacing= "5s"
		FallbackToSequentialModeOnSynchronized = false
		[Synchronizer.L1ParallelSynchronization.PerformanceWarning]
			AceptableInacctivityTime = "5s"
			ApplyAfterNumRollupReceived = 10

[Sequencer]
WaitPeriodPoolIsEmpty = "1s"
LastBatchVirtualizationTimeMaxWaitPeriod = "10s"
BlocksAmountForTxsToBeDeleted = 100
FrequencyToCheckTxsForDelete = "12h"
TxLifetimeCheckTimeout = "10m"
MaxTxLifetime = "3h"
	[Sequencer.Finalizer]
		GERDeadlineTimeout = "2s"
		ForcedBatchDeadlineTimeout = "5s"
		SleepDuration = "100ms"
		ResourcePercentageToCloseBatch = 10
		GERFinalityNumberOfBlocks = 0
		ClosingSignalsManagerWaitForCheckingL1Timeout = "10s"
		ClosingSignalsManagerWaitForCheckingGER = "10s"
		ClosingSignalsManagerWaitForCheckingForcedBatches = "10s"
		ForcedBatchesFinalityNumberOfBlocks = 0
		TimestampResolution = "10s"
		StopSequencerOnBatchNum = 0
	[Sequencer.DBManager]
		PoolRetrievalInterval = "500ms"
		L2ReorgRetrievalInterval = "5s"
	[Sequencer.StreamServer]
		Port = 6900
		Filename = "/datastreamer/datastream.bin"
		Enabled = true

[SequenceSender]
WaitPeriodSendSequence = "15s"
LastBatchVirtualizationTimeMaxWaitPeriod = "10s"
MaxTxSizeForL1 = 1073741824
L2Coinbase = "0x5465477Ce81D92Eba5eE9608402470FdAbcF34a0"
PrivateKey = {Path = "/pk/sequencer.keystore", Password = "testonly"}

[Aggregator]
Host = "0.0.0.0"
Port = 50081
RetryTime = "5s"
VerifyProofInterval = "10s"
TxProfitabilityCheckerType = "acceptall"
TxProfitabilityMinReward = "1.1"
ProofStatePollingInterval = "5s"
SenderAddress = "0x3c376e0711bBa2e41Cb2Ccc322F6134f94d3cf54"
CleanupLockedProofsInterval = "2m"
GeneratingProofCleanupThreshold = "10m"

[EthTxManager]
MaxTxLoadNum = 100
ForcedGas = 0
PrivateKeys = [
	{Path = "/pk/sequencer.keystore", Password = "testonly"},
	{Path = "/pk/aggregator.keystore", Password = "testonly"}
]

[L2GasPriceSuggester]
Type = "default"
UpdatePeriod = "10s"
Factor = 0.5
DefaultGasPriceWei = 1000000
MaxGasPriceWei = 0

[MTClient]
URI  = "zkevm-prover:50061"

[Executor]
URI = "zkevm-prover:50071"
MaxGRPCMessageSize = 10000000000

[Metrics]
Host = "0.0.0.0"
Port = 9091
Enabled = true
ProfilingHost = "0.0.0.0"
ProfilingPort = 6060
ProfilingEnabled = false

[EventLog]
	[EventLog.DB]
	User = "event_user"
	Password = "aZcK7kzJ8aU58uHE"
	Name = "event_db"
	Host = "db"
	Port = "5432"
	EnableLog = false
	MaxConns = 200

[HashDB]
User = "prover_user"
Password = "hpt4CjGqocp01xRI"
Name = "prover_db"
Host = "db"
Port = "5432"
EnableLog = false
MaxConns = 200
```

Create the docker-compose file.

```bash
$ vim docker-compose.yml
```

```yml
networks:
  default:
    name: zkevm

x-default-config: &default-config
  extra_hosts:
    - "db:119.13.103.230"
    - "zkevm-prover:116.202.169.210"
  logging:
    driver: "json-file"
    options:
      max-size: "100m"

services:

  zkevm-sequencer:
    container_name: zkevm-sequencer
    image: ghcr.io/terry1ee/qday-zkevm-node:20250304
    ports:
      - 9092:9091
      - 6060:6060
      - 6900:6900
    environment:
      - ZKEVM_NODE_STATE_DB_HOST=db
      - ZKEVM_NODE_POOL_DB_HOST=db
      - ZKEVM_NODE_MTCLIENT_URI=${ZKEVM_NODE_MTCLIENT_URI:-}
      - ZKEVM_NODE_EXECUTOR_URI=${ZKEVM_NODE_EXECUTOR_URI:-}
    volumes:
      - ./data/config/test.node.config.toml:/app/config.toml
      - ./data/config/test.genesis.config.json:/app/genesis.json
      - ./data/datastreamer:/datastreamer
    command:
      - "/bin/sh"
      - "-c"
      - "/app/b2-zkevm-node run --network custom --custom-network-file /app/genesis.json --cfg /app/config.toml --components sequencer"
    <<: *default-config

  zkevm-sequence-sender:
    container_name: zkevm-sequence-sender
    image: ghcr.io/terry1ee/qday-zkevm-node:20250304
    environment:
      - ZKEVM_NODE_STATE_DB_HOST=db
      - ZKEVM_NODE_POOL_DB_HOST=db
      - ZKEVM_NODE_SEQUENCER_SENDER_ADDRESS=0x5465477Ce81D92Eba5eE9608402470FdAbcF34a0
      - ZKEVM_NODE_MTCLIENT_URI=${ZKEVM_NODE_MTCLIENT_URI:-}
      - ZKEVM_NODE_EXECUTOR_URI=${ZKEVM_NODE_EXECUTOR_URI:-}
    volumes:
      - ./data/keystore/sequencer.keystore:/pk/sequencer.keystore
      - ./data/config/test.node.config.toml:/app/config.toml
      - ./data/config/test.genesis.config.json:/app/genesis.json
    command:
      - "/bin/sh"
      - "-c"
      - "/app/b2-zkevm-node run --network custom --custom-network-file /app/genesis.json --cfg /app/config.toml --components sequence-sender"
    <<: *default-config

  zkevm-json-rpc:
    container_name: zkevm-json-rpc
    image: ghcr.io/terry1ee/qday-zkevm-node:20250304
    ports:
      - 8123:8123
      - 8133:8133
      - 9091:9091
    environment:
      - ZKEVM_NODE_STATE_DB_HOST=db
      - ZKEVM_NODE_POOL_DB_HOST=db
      - ZKEVM_NODE_MTCLIENT_URI=${ZKEVM_NODE_MTCLIENT_URI:-}
      - ZKEVM_NODE_EXECUTOR_URI=${ZKEVM_NODE_EXECUTOR_URI:-}
    volumes:
      - ./data/config/test.node.config.toml:/app/config.toml
      - ./data/config/test.genesis.config.json:/app/genesis.json
    command:
      - "/bin/sh"
      - "-c"
      - "/app/b2-zkevm-node run --network custom --custom-network-file /app/genesis.json --cfg /app/config.toml --components rpc"
    <<: *default-config

  zkevm-aggregator:
    container_name: zkevm-aggregator
    image: ghcr.io/terry1ee/qday-zkevm-node:20250304
    ports:
      - 50081:50081
      - 9093:9091
    environment:
      - ZKEVM_NODE_STATE_DB_HOST=db
      - ZKEVM_NODE_AGGREGATOR_SENDER_ADDRESS=0x3c376e0711bBa2e41Cb2Ccc322F6134f94d3cf54
    volumes:
      - ./data/config/test.node.config.toml:/app/config.toml
      - ./data/config/test.genesis.config.json:/app/genesis.json
    command:
      - "/bin/sh"
      - "-c"
      - "/app/b2-zkevm-node run --network custom --custom-network-file /app/genesis.json --cfg /app/config.toml --components aggregator"
    <<: *default-config

  zkevm-sync:
    container_name: zkevm-sync
    image: ghcr.io/terry1ee/qday-zkevm-node:20250304
    ports:
      - 9095:9091
    environment:
      - ZKEVM_NODE_STATE_DB_HOST=db
      - ZKEVM_NODE_MTCLIENT_URI=${ZKEVM_NODE_MTCLIENT_URI:-}
      - ZKEVM_NODE_EXECUTOR_URI=${ZKEVM_NODE_EXECUTOR_URI:-}
    volumes:
      - ./data/config/test.node.config.toml:/app/config.toml
      - ./data/config/test.genesis.config.json:/app/genesis.json
    command:
      - "/bin/sh"
      - "-c"
      - "/app/b2-zkevm-node run --network custom --custom-network-file /app/genesis.json --cfg /app/config.toml --components synchronizer"
    <<: *default-config

  zkevm-eth-tx-manager:
    container_name: zkevm-eth-tx-manager
    image: ghcr.io/terry1ee/qday-zkevm-node:20250304
    ports:
      - 9094:9091
    environment:
      - ZKEVM_NODE_STATE_DB_HOST=db
    volumes:
      - ./data/keystore/sequencer.keystore:/pk/sequencer.keystore
      - ./data/keystore/aggregator.keystore:/pk/aggregator.keystore
      - ./data/config/test.node.config.toml:/app/config.toml
      - ./data/config/test.genesis.config.json:/app/genesis.json
    command:
      - "/bin/sh"
      - "-c"
      - "/app/b2-zkevm-node run --network custom --custom-network-file /app/genesis.json --cfg /app/config.toml --components eth-tx-manager"
    <<: *default-config

  zkevm-l2gaspricer:
    container_name: zkevm-l2gaspricer
    image: ghcr.io/terry1ee/qday-zkevm-node:20250304
    environment:
      - ZKEVM_NODE_POOL_DB_HOST=db
    volumes:
      - ./data/keystore/test.keystore:/pk/keystore
      - ./data/config/test.node.config.toml:/app/config.toml
      - ./data/config/test.genesis.config.json:/app/genesis.json
    command:
      - "/bin/sh"
      - "-c"
      - "/app/b2-zkevm-node run --network custom --custom-network-file /app/genesis.json --cfg /app/config.toml --components l2gaspricer"
    <<: *default-config

  zkevm-explorer-l2:
    container_name: zkevm-explorer-l2
    image: hermeznetwork/zkevm-explorer:latest
    ports:
      - 4001:4000
    environment:
      - NETWORK=POE
      - SUBNETWORK=Polygon Hermez
      - COIN=ETH
      - ETHEREUM_JSONRPC_VARIANT=geth
      - ETHEREUM_JSONRPC_HTTP_URL=http://zkevm-explorer-json-rpc:8124
      - DATABASE_URL=postgres://qday_explorer_user:Be5nfBEymMmQRS1D@db:5432/qday_explorer_db
      - ECTO_USE_SSL=false
      - MIX_ENV=prod
      - LOGO=/images/blockscout_logo.svg
      - LOGO_FOOTER=/images/blockscout_logo.svg
    command:
      - "/bin/sh"
      - "-c"
      - "mix do ecto.create, ecto.migrate; mix phx.server"
    <<: *default-config

  zkevm-explorer-json-rpc:
    container_name: zkevm-explorer-json-rpc
    image: ghcr.io/terry1ee/qday-zkevm-node:20250304
    ports:
      - 8124:8124
      - 8134:8134
    environment:
      - ZKEVM_NODE_STATE_DB_HOST=db
      - ZKEVM_NODE_POOL_DB_HOST=db
      - ZKEVM_NODE_RPC_PORT=8124
      - ZKEVM_NODE_RPC_WEBSOCKETS_PORT=8134
      - ZKEVM_NODE_MTCLIENT_URI=${ZKEVM_NODE_MTCLIENT_URI:-}
      - ZKEVM_NODE_EXECUTOR_URI=${ZKEVM_NODE_EXECUTOR_URI:-}
    volumes:
      - ./data/config/test.node.config.toml:/app/config.toml
      - ./data/config/test.genesis.config.json:/app/genesis.json
    command:
      - "/bin/sh"
      - "-c"
      - "/app/b2-zkevm-node run --network custom --custom-network-file /app/genesis.json --cfg /app/config.toml --components rpc --http.api eth,net,debug,zkevm,txpool,web3"
    <<: *default-config

  zkevm-approve:
    container_name: zkevm-approve
    image: ghcr.io/terry1ee/qday-zkevm-node:20250304
    environment:
      - ZKEVM_NODE_STATE_DB_HOST=db
    volumes:
      - ./data/keystore/sequencer.keystore:/pk/keystore
      - ./data/config/test.node.config.toml:/app/config.toml
      - ./data/config/test.genesis.config.json:/app/genesis.json
    command:
      - "/bin/sh"
      - "-c"
      - "/app/b2-zkevm-node approve --network custom --custom-network-file /app/genesis.json --key-store-path /pk/keystore --pw testonly --am 115792089237316195423570985008687907853269984665640564039457584007913129639935 -y --cfg /app/config.toml"
    <<: *default-config
```

Start the zkevm services.

```bash
$ docker compose up -d zkevm-approve
$ sleep 3 # wait for the zkevm-approve service to start
$ docker compose up -d zkevm-sync
$ sleep 4 # wait for the zkevm-sync service to start
$ docker compose up -d zkevm-eth-tx-manager
$ docker compose up -d zkevm-sequencer
$ docker compose up -d zkevm-sequence-sender
$ docker compose up -d zkevm-l2gaspricer
$ docker compose up -d zkevm-aggregator
$ docker compose up -d zkevm-json-rpc
$ sleep 30 # wait for the zkevm-json-rpc service to start
$ docker compose up -d zkevm-explorer-json-rpc
$ sleep 30 # wait for the zkevm-explorer-json-rpc service to start
$ docker compose up -d zkevm-explorer-l2
```

URLs

- QDAY Explorer: http://159.138.82.123:4001
- QDAY JSON-RPC: http://159.138.82.123:8123