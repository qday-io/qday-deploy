# Step-by-step Guide

<strong>Note:</strong>
1. Chain operators (Operator) need to perform all steps, while validators (Validator) only need to perform step 4.

## 1. Compile DA Node
- Clone https://github.com/qday-io/qday-zkevm-contracts.git and switch to the release branch
- Required environment and tools: docker, docker compose, wget, jq
- Install node environment: apt install nodejs npm -y
- Update configuration files as needed:
  - Create a .env file in the root directory and write your mnemonic
  - Update docker/scripts/deploy_parameters_docker.json
  - Update hardhat.config.js, add networks as needed
- Run `start2.sh` in the root directory
- The output directory out will generate:
  - deploy_output.json

  **Configuration details** [da-config.md](./step-by-step/da-config.md)

## 2. Create keystore by MNEMONIC
- git clone https://github.com/qday-io/qday-deploy.git
- Install node environment: apt install nodejs npm -y
- Install dependencies: npm install ethers@^5.7.2
- Read MNEMONIC from .env
- Create aggregator.keystore and sequencer.keystore via CLI
- It is recommended to use the script to automatically generate keystore files:

  ```sh
  bash tools/gen-keystore.sh
  ```
  
Now, the keystore files will be generated and saved in the `temp_keystore` directory at the project root. This directory will be created automatically, no manual operation required.

Select two of the generated keystore files, rename them to aggregator.keystore and sequencer.keystore, and place them in the data/keystore directory (**must correspond to deploy_output.json**).

Example commands:
```sh
[ -d data/keystore ] || mkdir -p data/keystore
cp temp_keystore/1.keystore data/keystore/sequencer.keystore
cp temp_keystore/2.keystore data/keystore/aggregator.keystore
```

## 3. Run DA Node (L1 Node)

  **Note: Switch to qday-deploy**

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

### Compile Main Node

- Update configuration files:
  - data/config/test.genesis.config.json
  - data/config/test.node.config.toml
  - data/config/test.prover.config.json

  **Configuration details** [main-node-config.md](./step-by-step/main-node-config.md)

### Run Main Node

- Start main node:
  ```sh
  make main-node
  ```
- Stop main node:
  ```sh
  make stop-main-node
  ```

> If you need to reinitialize, the system will automatically update if root verification fails

## 5. RPC Node

### Configuration parameters
- Update configuration files:
  - data/config/test.genesis.config.json (**must be consistent with main node, cannot be changed**)
  - data/config/rpc1.node.config.toml
  - data/config/rpc1.prover.config.json

  **Configuration details** [rpc-node-config.md](./step-by-step/rpc-node-config.md)

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

> If you need to reinitialize, the system will automatically update if root verification fails


## 6. Deploy committer

**Switch to the committer directory**

### 1. Directory structure

- `docker-compose.yml`: Service orchestration file, defines committer and its dependent database.
- `env.example`: Environment variable template, copy to `.env` and modify as needed before deployment.
- `mysql.sql`: MySQL initialization script, automatically imports database table structure.

### 2. Dependencies

- Docker and Docker Compose
- Recommended host memory ≥ 2GB

### 3. Environment variable configuration

Copy `env.example` to `.env` and modify as needed. Main variable descriptions:
- `ETHERMINT_IMAGE`: committer service image, by default points to the official repository.
- Other parameters are related to chain, node, account, API, etc. See the `env.example` file for details.

### 4. Data volume description

- `./mysql1/datadir`: MySQL data persistence directory (will be created automatically when docker-compose starts).
- `./mysql.sql`: Database initialization script, automatically imported.

### 5. Port mapping

- `3366:3306`: MySQL database service port

### 6. Start service

In the `committer` directory, execute:

```bash
cp env.example .env
# If you need to customize the database structure, modify mysql.sql

docker-compose up -d
```
### 7. Check

??

**Detailed configuration [committer-config.md](./step-by-step/committer-config.md)** 

## 7. Check RPC Node and Rollup

- Verify main node
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

- Verify da node 
```
curl http://localhost:8545 \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc": "2.0", "method": "eth_chainId", "params": [], "id": 1}'
```

Expected response:
```
  {"jsonrpc":"2.0","id":1,"result":"0x2328"}
```

- Verify Rollup

> 1. Import qday network to Metamask
> 2. Import account: aea0e727a9a1b1dd50df66ed47b8cf1925ba5a0d67f785349a29ec304320396d
> 3. Check this account (0xD47dac7F1916054A7223A2E63C00635a64fa93A7) balance: 210000000000000000000000000
> 4. Use this account to **initiate multiple transactions**
> 5. Use tools/batch tool to verify rollup is working normally (may need to wait 3~12 minutes)
