# Step-by-step Guide

<strong>Note:</strong> 
1. The chain operator (Operator) needs to follow all steps, while a validator (Validator) only needs to follow step 4.
2. git clone https://github.com/qday-io/qday-deploy.git

## 1. Create keystore by MNEMONIC
- Read the MNEMONIC from the .env file
- You can use the script to automatically generate keystore files:

  ```sh
  bash tools/gen-keystore.sh
  ```
  <small>The keystore files will be generated and saved in the <code>temp_keystore</code> directory at the project root. This directory is created automatically.</small>

  After generation, select two of the keystore files, rename them to aggregator.keystore and sequencer.keystore, and place them in the data/keystore directory.

  Example commands:
  ```sh
  [ -d data/keystore ] || mkdir -p data/keystore
  cp temp_keystore/1.keystore data/keystore/aggregator.keystore
  cp temp_keystore/0.keystore data/keystore/sequencer.keystore
  ```

## 2. Start DA Node (L1 Node)
- Clone https://github.com/qday-io/qday-zkevm-contracts.git and checkout the release branch
- Update configuration files as needed:
  - Create a .env file in the project root and add your mnemonic
  - Update docker/scripts/deploy_parameters_docker.json
  - Update hardhat.config.js to add networks as needed
- Run `start2.sh` in the project root
- The out directory will contain:
  - genesis.json
  - deploy_output.json
  - deploy_parameters_docker.json
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

## 3. Start Main Node
- Update configuration files:
  - data/config/test.genesis.config.json
  - data/config/test.node.config.toml
  - data/config/test.prover.config.json
- Start main node:
  ```sh
  make main-node
  ```
- Stop main node:
  ```sh
  make stop-main-node
  ```

> If you need to reinitialize, the system will automatically update if root validation fails.

## 4. Start RPC Node
- Update configuration files:
  - data/config/test.genesis.config.json
  - data/config/test.node.config.toml
  - data/config/test.prover.config.json
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