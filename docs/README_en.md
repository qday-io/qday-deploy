# Step-by-step Guide

<strong>Note:</strong>
1. The chain operator (Operator) should follow all steps; a validator (Validator) only needs to perform step 4.
2. git clone https://github.com/qday-io/qday-deploy.git

## 1. Create keystore by MNEMONIC
- Read the MNEMONIC from the .env file
- Use the CLI to create aggregator.keystore and sequencer.keystore
- It is recommended to use the script to automatically generate keystore files:

  ```sh
  bash tools/gen-keystore.sh
  ```

The keystore files will be generated and saved in the `temp_keystore` directory at the project root. This directory is created automatically.

Select two of the generated keystore files, rename them to aggregator.keystore and sequencer.keystore, and place them in the data/keystore directory.

Example commands:
```sh
[ -d data/keystore ] || mkdir -p data/keystore
cp temp_keystore/1.keystore data/keystore/aggregator.keystore
cp temp_keystore/0.keystore data/keystore/sequencer.keystore
```

## 2. DA Node (L1 Node)

### Build DA Node
- Clone https://github.com/qday-io/qday-zkevm-contracts.git and switch to the release branch
- Update configuration files as needed:
  - Create a .env file in the root directory and add your mnemonic
  - Update docker/scripts/deploy_parameters_docker.json
  - Update hardhat.config.js to add networks as needed
- Run `start2.sh` in the root directory
- The out directory will contain:
  - deploy_output.json

  **Configuration details:** [da-config.md](./step-by-step/da-config.md)

### Run DA Node

  **Note: Switch to qday-deploy directory**

- Start DA Node:
  ```sh
  make da-node
  ```
- Stop DA Node:
  ```sh
  make stop-da-node
  ```
- Restart DA Node:
  ```sh
  make restart-da-node
  ```

## 3. Main Node

### Build Main Node

- Update configuration files:
  - data/config/test.genesis.config.json
  - data/config/test.node.config.toml
  - data/config/test.prover.config.json

  **Configuration details:** [main-node-config.md](./step-by-step/main-node-config.md)

### Run Main Node

- Start main node:
  ```sh
  make main-node
  ```
- Stop main node:
  ```sh
  make stop-main-node
  ```

> If you need to reinitialize, the system will automatically update if root validation fails.

## 4. RPC Node

### Configuration
- Update configuration files:
  - data/config/test.genesis.config.json (**must be identical to main node**)
  - data/config/rpc1.node.config.toml
  - data/config/rpc1.prover.config.json

  **Configuration details:** [rpc-node-config.md](./step-by-step/rpc-node-config.md)

### Run RPC Node
- Start RPC node:
  ```sh
  make rpc-node
  ```
- Stop RPC node:
  ```sh
  make stop-rpc-node
  ```
- Restart RPC node:
  ```sh
  make restart-rpc-node
  ```

> If you need to reinitialize, the system will automatically update if root validation fails. 