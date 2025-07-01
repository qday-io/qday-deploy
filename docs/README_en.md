# Step-by-step Guide

<strong>Note:</strong>
1. The chain operator (Operator) should follow all steps; a validator (Validator) only needs to perform step 4.

## 1. Build DA Node
- Clone https://github.com/qday-io/qday-zkevm-contracts.git and switch to the release branch
- Required environment and tools: docker, docker compose, wget, jq
- Install node: apt install nodejs npm -y
- Update configuration files as needed:
  - Create a .env file in the root directory and add your mnemonic
  - Update docker/scripts/deploy_parameters_docker.json
  - Update hardhat.config.js to add networks as needed
- Run `start2.sh` in the root directory
- The out directory will contain:
  - deploy_output.json

  **Configuration details:** [da-config.md](./step-by-step/da-config.md)

## 2. Create keystore by MNEMONIC
- git clone https://github.com/qday-io/qday-deploy.git
- Install node: apt install nodejs npm -y
- Install dependency: npm install ethers@^5.7.2
- Read the MNEMONIC from the .env file
- Use the CLI to create aggregator.keystore and sequencer.keystore
- It is recommended to use the script to automatically generate keystore files:

  ```sh
  bash tools/gen-keystore.sh
  ```

The keystore files will be generated and saved in the `temp_keystore` directory at the project root. This directory is created automatically.

Select two of the generated keystore files, rename them to aggregator.keystore and sequencer.keystore, and place them in the data/keystore directory (**make sure they correspond to deploy_output.json**).

Example commands:
```sh
[ -d data/keystore ] || mkdir -p data/keystore
cp temp_keystore/1.keystore data/keystore/sequencer.keystore
cp temp_keystore/2.keystore data/keystore/aggregator.keystore
```

## 3. Run DA Node (L1 Node)

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

## 4. Main Node

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

## 5. RPC Node

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

## 6. Check RPC Node

```
curl http://localhost:8123 \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc": "2.0", "method": "eth_chainId", "params": [], "id": 1}'
```

Expected response:
```
  {"jsonrpc":"2.0","id":1,"result":"0x3e9"}
```

## 7. Deploy wAbel Contract

- Clone https://github.com/qday-io/qday-contracts.git and switch to the release branch
- Install required dependencies and tools

```
# Install Rust (if not already installed)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env

# Install Foundry
cargo install --git https://github.com/foundry-rs/foundry.git foundry-cli anvil --bins --locked
```

- Create .env and update

```
 cp env-example .env
```

- Run shell

```jsonc

Usage: ./deploy.sh [OPTIONS]

Options:
  -l, --local     Deploy to local network (requires anvil running)
  -m, --mainnet   Deploy to Ethereum mainnet (QDay)
  -s, --simulate  Simulate deployment (no transaction sent)
  -v, --verify    Verify contract after deployment (mainnet only)
  -h, --help      Show this help message

Examples:
  ./deploy.sh --local                    # Local deployment
  ./deploy.sh --mainnet                  # Mainnet deployment
  ./deploy.sh --simulate                 # Simulate deployment
  ./deploy.sh --mainnet --verify         # Mainnet deployment and verify

Environment Variables:
  PRIVATE_KEY     Deployer's private key (required)
  ETH_RPC_URL     Ethereum RPC URL (required for mainnet)
  ETHERSCAN_API_KEY Etherscan API Key (required for verification)
```

- out.txt

 1. Deployment process info, including errors
 2. Deployment result info, such as contract address, network info, etc.


## 8. Deploy indexer

**Switch to the indexer directory**

### 1. Directory Structure

- `docker-compose.yml`: Compose file defining indexer and its database.
- `env-example`: Environment variable template. Copy to `.env` and modify as needed before deployment.
- `abi.json`: Contract ABI file for indexer service.

### 2. Requirements

- Docker and Docker Compose
- Recommended host memory ≥ 2GB

### 3. Environment Variables

Copy `env-example` to `.env` and modify as needed. Key variables:
- `INDEXER_DATABASE_SOURCE`: Postgres connection string (default points to the pg service in this compose).
- `BITCOIN_*`, `BITCOIN_BRIDGE_*`: Bitcoin network and bridge contract configs.
- See `env-example` for more details.

### 4. Data Volumes

- `./db/postgres/datadir`: Postgres data directory.
- `./abi.json`: ABI file, mapped to `/app/abi.json` in the container.
- `./.env`: Environment file, mapped to `/app/.env` in the container.

### 5. Port Mapping

- `5432:5432`: Postgres database
- `9090:9090`, `9091:9091`: indexer service

### 6. Start Service

In the `indexer` directory:

```bash
cp env-example .env
# If you have init SQL, put it in docker-entrypoint-initdb.d

docker-compose up -d
```

### 7. Check
TODO

**Configuration details:** [indexer-config.md](./step-by-step/indexer-config.md)


## 9. Deploy committer

**Switch to the committer directory**

### 1. Directory Structure

- `docker-compose.yml`: Compose file defining committer and its database.
- `env.example`: Environment variable template. Copy to `.env` and modify as needed before deployment.
- `mysql.sql`: MySQL init script, auto-imported for DB structure.

### 2. Requirements

- Docker and Docker Compose
- Recommended host memory ≥ 2GB

### 3. Environment Variables

Copy `env.example` to `.env` and modify as needed. Key variables:
- `ETHERMINT_IMAGE`: committer service image (default points to official repo).
- Other variables for chain, node, account, API, etc. See `env.example` for details.

### 4. Data Volumes

- `./mysql1/datadir`: MySQL data directory (auto-created by docker-compose).
- `./mysql.sql`: DB init script, auto-imported.

### 5. Port Mapping

- `3366:3306`: MySQL database

### 6. Start Service

In the `committer` directory:

```bash
cp env.example .env
# To customize DB structure, edit mysql.sql

docker-compose up -d
```
### 7. Check
TODO

**Configuration details:** [committer-config.md](./step-by-step/committer-config.md) 