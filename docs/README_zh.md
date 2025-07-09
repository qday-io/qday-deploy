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


## 6. 部署 committer

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



## 7. 检查PRC节点

- Verify main node
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

- Verify da node 
```
curl http://localhost:8545 \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc": "2.0", "method": "eth_chainId", "params": [], "id": 1}'
```

正常响应：
```
  {"jsonrpc":"2.0","id":1,"result":"0x2328"}
```

- Metamask 导入账户

1. 导入qday 网络
2. 导入帐号：aea0e727a9a1b1dd50df66ed47b8cf1925ba5a0d67f785349a29ec304320396d 
3. 查阅此帐号(0xD47dac7F1916054A7223A2E63C00635a64fa93A7)余额： 210000000000000000000000000
4. 使用此帐号,**发起多笔交易**
5. 使用 tools/batch 工具验证rollup 正常（可能需要等待 3～12分钟）

