# Step-by-step Guide


<strong>注意：</strong>
1. 链的运营者（Operator）需要执行全部流程,验证者（Validator）仅需要执行第4步。


## 1. 编译DA Node
- 克隆 https://github.com/qday-io/qday-zkevm-contracts.git 并切换到 release 分支
- 必要环境和工具：docker ,docker compose, wget,jq
- 安装node环境：apt install nodejs npm -y
- 按需更新配置文件：
  - 在根目录创建 .env，写入你的 mnemonic
  - 更新 docker/scripts/deploy_parameters_docker.json
  - 更新 hardhat.config.js，按需添加网络
- 在根目录执行 `start2.sh`
- 输出目录 out 下会生成：
  - deploy_output.json


  **配置详情** [da-config.md](./step-by-step/da-config.md)

## 2. 创建 keystore by MNEMONIC
- git clone https://github.com/qday-io/qday-deploy.git
- 安装node环境：apt install nodejs npm -y 
- 安装依赖：npm install ethers@^5.7.2
- 读取 .env 获取 MNEMONIC
- 通过 CLI 创建 aggregator.keystore、sequencer.keystore
- 推荐使用脚本自动生成 keystore 文件：

  ```sh
  bash tools/gen-keystore.sh
  ```
  
现在，keystore 文件会被生成并保存在项目根目录下的 `temp_keystore` 目录中。该目录会自动创建，无需手动操作。

根据生成的 keystore 文件，选取其中两个，分别重命名为 aggregator.keystore 和 sequencer.keystore，并放入 data/keystore 目录下(**一定和 deploy_output.json 对应**)。

命令示例：
```sh
[ -d data/keystore ] || mkdir -p data/keystore
cp temp_keystore/1.keystore data/keystore/sequencer.keystore
cp temp_keystore/2.keystore data/keystore/aggregator.keystore
```

## 3.  运行DA Node（L1 节点）

  **注意：切换到qday-deploy**

- 启动 DA Node：
  ```sh
  make da-node
  ```
- 停止 DA Node：
  ```sh
  make stop-da-node
  ```
- 重启 DA Node：
  ```sh
  make restart-da-node
  ```


## 4. Main Node（主节点）

### 编译Main Node

- 更新配置文件：
  - data/config/test.genesis.config.json
  - data/config/test.node.config.toml
  - data/config/test.prover.config.json

  **配置详情** [main-node-config.md](./step-by-step/main-node-config.md)

### 运行Main Node

- 启动主节点：
  ```sh
  make main-node
  ```
- 停止主节点：
  ```sh
  make stop-main-node
  ```

> 如需重新初始化，因为系统校验 root 失败并自动更新下了

## 5. RPC Node

### 配置参数
- 更新配置文件：
  - data/config/test.genesis.config.json （**同 main node 一致，不能改变**）
  - data/config/rpc1.node.config.toml
  - data/config/rpc1.prover.config.json

  **配置详情** [rpc-node-config.md](./step-by-step/rpc-node-config.md)

### 运行RPC Node
- 启动 RPC 节点：
  ```sh
  make rpc-node
  ```
- 停止 RPC 节点：
  ```sh
  make stop-rpc-node
  ```
- 重启 RPC 节点：
  ```sh
  make restart-rpc-node
  ```

> 如需重新初始化，因为系统校验 root 失败并自动更新下了


## 6. 检查PRC节点

```
curl http://localhost:8123 \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc": "2.0", "method": "eth_chainId", "params": [], "id": 1}'
```

正常响应：
```
  {"jsonrpc":"2.0","id":1,"result":"0x3e9"}
```

## 7. 部署wAbel 合约

- 克隆 https://github.com/qday-io/qday-contracts.git 并切换到release 分支
- 安装必要依赖和工具

```
# 安装 Rust（如果还没有安装）
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env

# 安装 Foundry
cargo install --git https://github.com/foundry-rs/foundry.git foundry-cli anvil --bins --locked
```

- 创建.env and update

```
 cp env-example .env
```

- run shell

```jsonc

Usage: ./deploy.sh [OPTIONS]

Options:
  -l, --local     部署到本地网络 (需要先启动 anvil)
  -m, --mainnet   部署到 Ethereum 主网（对我们即是QDay）
  -s, --simulate  模拟部署 (不发送交易)
  -v, --verify    部署后验证合约 (仅主网)
  -h, --help      显示此帮助信息

Examples:
  ./deploy.sh --local                    # 本地部署
  ./deploy.sh --mainnet                  # 主网部署
  ./deploy.sh --simulate                 # 模拟部署
  ./deploy.sh --mainnet --verify         # 主网部署并验证

Environment Variables:
  PRIVATE_KEY     部署者私钥 (必需)
  ETH_RPC_URL     Ethereum RPC URL (主网部署时必需)
  ETHERSCAN_API_KEY Etherscan API Key (验证时必需)
```

- out.txt

 1. 部署过程中信息 如错误信息等
 2. 部署结果信息，如合约地址，网络信息等


## 8.部署 indexer

**切换到 indexer 目录**

### 1. 目录结构

- `docker-compose.yml`：服务编排文件，定义了 indexer 及其依赖数据库。
- `env-example`：环境变量模板，部署前请复制为 `.env` 并根据实际情况修改。
- `abi.json`：合约 ABI 文件，供 indexer 服务使用。

### 2. 依赖环境

- Docker 及 Docker Compose
- 推荐主机内存 ≥ 2GB

### 3. 环境变量配置

将 `env-example` 复制为 `.env` 并根据实际需求修改。主要变量说明：
- `INDEXER_DATABASE_SOURCE`：Postgres 数据库连接串，默认已指向本 compose 内的 pg 服务。
- `BITCOIN_*`、`BITCOIN_BRIDGE_*`：比特币网络、桥接合约等相关配置。
- 其余参数请参考 `env-example` 注释。

### 4. 数据卷说明

- `./db/postgres/datadir`：Postgres 数据持久化目录。
- `./abi.json`：合约 ABI 文件，需与 indexer 镜像内 `/app/abi.json` 映射。
- `./.env`：环境变量文件，需与 indexer 镜像内 `/app/.env` 映射。

### 5. 端口映射

- `5432:5432`：Postgres 数据库服务端口
- `9090:9090`、`9091:9091`：indexer 服务端口

### 6. 启动服务

在 `indexer` 目录下执行：

```bash
cp env-example .env
# 如有初始化 SQL，可放入 docker-entrypoint-initdb.d 目录

docker-compose up -d
```

### 7. 检查
？？


**详细配置 [indexer-config.md](./step-by-step/indexer-config.md)**


## 9. 部署 committer

**切换到 committer 目录**

### 1. 目录结构

- `docker-compose.yml`：服务编排文件，定义 committer 及其依赖数据库。
- `env.example`：环境变量模板，部署前请复制为 `.env` 并根据实际情况修改。
- `mysql.sql`：MySQL 初始化脚本，自动导入数据库表结构。

### 2. 依赖环境

- Docker 及 Docker Compose
- 推荐主机内存 ≥ 2GB

### 3. 环境变量配置

将 `env.example` 复制为 `.env` 并根据实际需求修改。主要变量说明：
- `ETHERMINT_IMAGE`：committer 服务镜像，默认已指向官方仓库。
- 其余参数为链、节点、账户、API 等相关配置，详见 `env.example` 文件。

### 4. 数据卷说明

- `./mysql1/datadir`：MySQL 数据持久化目录（docker-compose 启动时会自动创建）。
- `./mysql.sql`：数据库初始化脚本，自动导入。

### 5. 端口映射

- `3366:3306`：MySQL 数据库服务端口

### 6. 启动服务

在 `committer` 目录下执行：

```bash
cp env.example .env
# 如需自定义数据库结构，可修改 mysql.sql

docker-compose up -d
```
### 7.检查

？？

**详细配置 [committer-config.md](./step-by-step/committer-config.md)**

