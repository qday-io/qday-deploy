## Main Node Config

main node config 配置参数详细说明

---
- ### test.genesis.config.json

```jsonc
{
  // L1 chain configuration
  "l1Config": {
    // L1 chain ID
    "chainId": 9000,
    // Polygon zkEVM contract address on L1
    "polygonZkEVMAddress": "0x40fCD7B3cBF0a3cDeBEcec3D3429FB207b94df09",
    // MATIC token contract address on L1
    "maticTokenAddress": "0x83c8731Efc22a045DB11EA6C15F1455939b2fb14",
    // GlobalExitRoot contract address on L1
    "polygonZkEVMGlobalExitRootAddress": "0x4e70560c47A7938b754F03e40ce4Eef3aEfFb9e3"
  },
  // The block number at which the genesis state is set
  "genesisBlockNumber": 26,
  // The genesis state root
  "root": "0xbafcd3cad35e80e8bee8178fbf8ad4adb3124d48f1fe1cb2bccd2d7db24fa3be",
  // List of genesis accounts and contracts
  "genesis": [
    {
      // Contract or account name
      "contractName": "PolygonZkEVMDeployer",
      // Initial balance (in wei)
      "balance": "0",
      // Initial nonce
      "nonce": "4",
      // Account or contract address
      "address": "0xB30E21FF3e05BB99cF10fd5887a947Da1a6160A2",
      // Contract bytecode (if contract)
      "bytecode": "...",
      // Initial storage mapping (if contract)
      "storage": {
        // storage slot: value
        "0x...": "0x..."
      }
    },
    // Example: Initialize a normal EOA account with a starting balance
    {
      // Account name or description
      "accountName": "user1",
      // Initial balance in wei (e.g., 1 ETH = 1e18 wei)
      "balance": "1000000000000000000", // 1 ETH
      // Initial nonce
      "nonce": "0",
      // EOA address
      "address": "0x1234567890abcdef1234567890abcdef12345678"
      // No bytecode or storage for EOA
    }
    // ... more accounts/contracts
  ]
}
```

1. > You can initialize EOA accounts with a starting balance by adding them to the `genesis` array. For EOA, only `accountName`, `balance`, `nonce`, and `address` are required. The `balance` is specified in wei.

2. >l1Config2.`chainId` Keep it the same，
3. >l1Config2 other fields from deploy_output.json from DA node of build
4. >`genesisBlockNumber` from deploy_output.json
5. >`root` If you change genesis, root will automatically change
6. >You can also initialize accounts in the genesis block


---


- ### test.node.config.toml

```toml
# Whether this node is a trusted sequencer
IsTrustedSequencer = true

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

# ...（其余字段同理，建议只保留一部分示例，或如需全部字段注释请告知）
```
---
- ### test.prover.config.json

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

  // ...（其余字段同理，建议只保留一部分示例，或如需全部字段注释请告知）
}
```