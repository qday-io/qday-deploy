## DA-Config

DA Node configuration parameter details

---

**deploy_parameters_docker.json**

```jsonc
{
  // Whether to use a real verifier contract (true) or a mock verifier (false, for test/dev)
  "realVerifier": false,

  // The URL of the trusted sequencer's JSON-RPC endpoint, used for L1<->L2 communication
  "trustedSequencerURL": "http://zkevm-json-rpc:8123",

  // The name of the network, used for identification and display
  "networkName": "zkevm",

  // The version of the deployment or protocol
  "version": "0.0.1",

  // The address of the trusted sequencer (EOA or contract), responsible for sequencing L2 blocks
  "trustedSequencer": "0x3c376e0711bBa2e41Cb2Ccc322F6134f94d3cf54",

  // The chain ID for this zkEVM network (must be unique and match L2 config)
  "chainID": 1001,

  // The address of the trusted aggregator, responsible for submitting proofs to L1
  "trustedAggregator": "0x5465477Ce81D92Eba5eE9608402470FdAbcF34a0",

  // Timeout (in seconds) for the trusted aggregator to submit proofs before others can
  "trustedAggregatorTimeout": 604799,

  // Timeout (in seconds) for pending state before it is considered invalid
  "pendingStateTimeout": 604799,

  // Fork ID, used to distinguish different protocol upgrades or testnets
  "forkID": 6,

  // The admin address with special permissions (e.g., contract upgrades)
  "admin": "0xf4EF6650E48d099a4972ea5B414daB86e1998Bd3",

  // The owner address of the zkEVM contract (can perform privileged actions)
  "zkEVMOwner": "0xf4EF6650E48d099a4972ea5B414daB86e1998Bd3",

  // The address of the timelock contract for governance actions
  "timelockAddress": "0xf4EF6650E48d099a4972ea5B414daB86e1998Bd3",

  // Minimum delay (in seconds) for timelock contract actions
  "minDelayTimelock": 3600,

  // Salt value for deterministic contract deployment (should be unique per deployment)
  "salt": "0x0000000000000000000000000000000000000000000000000000000000000000",

  // The initial owner of the zkEVM deployer contract
  "initialZkEVMDeployerOwner": "0xf4EF6650E48d099a4972ea5B414daB86e1998Bd3",

  // (Optional) The address of the MATIC token contract, if used
  "maticTokenAddress": "",

  // (Optional) The address of the zkEVM deployer contract, if already deployed
  "zkEVMDeployerAddress": ""
}
```

**Parameter notes:**

1. `forkID`: must keep, do not change
2. `chainID`: The chain ID for this zkEVM network (must be unique and match L2 config). zkEVM network will get chainID from contracts if not configured on L2.
3. `trustedSequencerURL`: zkEVM network will get the URL from contracts if not configured on L2.
4. All addresses: script will be automatically generated depending on MNEMONIC.

---

**hardhat.config.js**

Add a network configuration under `networks`. Usually, you do not need to change it. The default is `localhost` for local image build and usage.

```js
localhost: {
    // The RPC URL for the local Ethereum node (usually Hardhat or Ganache)
    url: 'http://127.0.0.1:8545',
    accounts: {
        // The mnemonic phrase used to generate accounts
        mnemonic: process.env.MNEMONIC || DEFAULT_MNEMONIC,
        // The derivation path for HD wallets
        path: "m/44'/60'/0'/0",
        // The initial index to start deriving accounts
        initialIndex: 0,
        // The number of accounts to generate
        count: 20,
    }
}
```

---

**deploy_output.json**

```jsonc
{
  // The deployed Polygon zkEVM main contract address
  "polygonZkEVMAddress": "0x40fCD7B3cBF0a3cDeBEcec3D3429FB207b94df09",

  // The deployed Polygon zkEVM Bridge contract address (for cross-chain asset transfers)
  "polygonZkEVMBridgeAddress": "0x27B7520794C53F5196389fCA2B0a3bC3eDc10484",

  // The deployed GlobalExitRoot contract address (tracks exit roots for L1/L2 communication)
  "polygonZkEVMGlobalExitRootAddress": "0x4e70560c47A7938b754F03e40ce4Eef3aEfFb9e3",

  // The deployed MATIC token contract address (if used)
  "maticTokenAddress": "0x83c8731Efc22a045DB11EA6C15F1455939b2fb14",

  // The deployed Verifier contract address (verifies zk-proofs)
  "verifierAddress": "0x1Fd6B4cb58196880Ecb304E605CAbBe1d10b7867",

  // The deployed zkEVM Deployer contract address (for deploying zkEVM contracts)
  "zkEVMDeployerContract": "0xc410A3f50A99D3265Ae6910125Ea1d8b6ab9c76e",

  // The address that performed the deployment (deployer EOA)
  "deployerAddress": "0xf4EF6650E48d099a4972ea5B414daB86e1998Bd3",

  // The deployed Timelock contract address (for governance and upgrade delays)
  "timelockContractAddress": "0x9B1b0Aaa3e95C94326A692Ee13FEb65d7E1b936F",

  // The block number at which the deployment started
  "deploymentBlockNumber": 26,

  // The block number at which the deployment finished
  "finalDeploymentBlockNumber": 27,

  // The genesis state root for the zkEVM chain
  "genesisRoot": "0xc856e065657a0a1ab5cd8e07c18fa35883301b360e5c4738f491baf0ea994ed0",

  // The trusted sequencer address (EOA or contract)
  "trustedSequencer": "0x3c376e0711bBa2e41Cb2Ccc322F6134f94d3cf54",

  // The trusted sequencer's JSON-RPC endpoint URL
  "trustedSequencerURL": "http://zkevm-json-rpc:8123",

  // The chain ID for this zkEVM network
  "chainID": 1001,

  // The name of the network
  "networkName": "zkevm",

  // The admin address with special permissions
  "admin": "0xf4EF6650E48d099a4972ea5B414daB86e1998Bd3",

  // The trusted aggregator address (submits proofs to L1)
  "trustedAggregator": "0x5465477Ce81D92Eba5eE9608402470FdAbcF34a0",

  // The deployed ProxyAdmin contract address (manages proxy upgrades)
  "proxyAdminAddress": "0x6853a32731EFD807776cD80118268f828c9e6C0f",

  // Fork ID for protocol upgrades or testnet distinction
  "forkID": 6,

  // Salt value for deterministic contract deployment
  "salt": "0x0000000000000000000000000000000000000000000000000000000000000000",

  // The deployment version string
  "version": "0.0.1",

  // The latest block number at the time of deployment output
  "latestBlockNumber": 29,

  // The ISO timestamp when this deployment output was last updated
  "updatedAt": "2025-06-21T05:02:35.816Z"
}
```

> The `deploy_output.json` will be used as the config for L2.

