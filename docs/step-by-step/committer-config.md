# Committer 配置文件字段说明

本文档详细说明 committer 服务配置文件中各个字段的含义、类型、默认值及配置建议。

## 配置分组

### 1. 区块链基础配置

| 字段名 | 类型 | 默认值 | 说明 | 配置建议 |
|--------|------|--------|------|----------|
| `RPC_URL` | string | `https://polygon-rpc.com` | 区块链 RPC 节点地址 | 配置为实际可用的 RPC 节点 |
| `BLOCKCHAIN` | string | `polygon` | 区块链网络名称 | 根据实际网络修改（如：polygon, ethereum） |
| `INIT_BLOCK_NUMBER` | int | `12345678` | 初始同步区块号 | 配置为开始同步的区块高度 |
| `INIT_BLOCK_HASH` | string | `0xabcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890` | 初始区块哈希 | 配置为对应区块的哈希值 |
| `POLYGON_ZKEVM_ADDRESS` | string | `0x1234567890abcdef1234567890abcdef12345678` | Polygon zkEVM 合约地址 | 配置为实际的 zkEVM 合约地址 |

### 2. 提案和批次配置

| 字段名 | 类型 | 默认值 | 说明 | 配置建议 |
|--------|------|--------|------|----------|
| `PROPOSAL_BATCHES_LIMITNUM` | int | `10` | 提案批次限制数量 | 根据业务需求调整 |
| `INIT_PROPOSAL_ID` | int | `1` | 初始提案 ID | 配置为开始处理的提案 ID |

### 3. B2Node 节点配置

| 字段名 | 类型 | 默认值 | 说明 | 配置建议 |
|--------|------|--------|------|----------|
| `B2NODE_PRIVATE_KEY` | string | `your_b2node_private_key` | B2Node 私钥 | 配置为实际的私钥（注意安全） |
| `B2NODE_ADDRESS` | string | `0xabcdefabcdefabcdefabcdefabcdefabcdefabcd` | B2Node 地址 | 配置为对应的公钥地址 |
| `B2NODE_CHAIN_ID` | int | `80001` | B2Node 链 ID | 根据实际网络配置 |
| `B2NODE_GRPC_HOST` | string | `localhost` | B2Node gRPC 主机地址 | 配置为实际的 gRPC 服务地址 |
| `B2NODE_GRPC_PORT` | int | `9090` | B2Node gRPC 端口 | 配置为实际的 gRPC 端口 |
| `B2NODE_RPC_URL` | string | `http://localhost:8545` | B2Node RPC URL | 配置为实际的 RPC 地址 |
| `B2NODE_COIN_DENOM` | string | `abecoin` | B2Node 代币名称 | 配置为实际的代币符号 |

### 4. API 和认证配置

| 字段名 | 类型 | 默认值 | 说明 | 配置建议 |
|--------|------|--------|------|----------|
| `ENDPOINT` | string | `https://api.example.com` | API 端点地址 | 配置为实际的 API 服务地址 |
| `RPCENDPOINT` | string | `https://rpc.example.com` | RPC 端点地址 | 配置为实际的 RPC 服务地址 |
| `USERNAME` | string | `admin` | API 用户名 | 配置为实际的用户名 |
| `PASSWORD` | string | `yourpassword` | API 密码 | 配置为实际的密码（注意安全） |
| `APPID` | string | `yourappid` | 应用 ID | 配置为实际的应用标识 |
| `REQUEST_SIGNATURE` | string | `your_signature` | 请求签名 | 配置为实际的签名密钥 |
| `USERID` | string | `youruserid` | 用户 ID | 配置为实际的用户标识 |

### 5. 交易配置

| 字段名 | 类型 | 默认值 | 说明 | 配置建议 |
|--------|------|--------|------|----------|
| `FROM` | string | `0xabcdefabcdefabcdefabcdefabcdefabcdefabcd` | 发送方地址 | 配置为实际的发送地址 |
| `RECIPIENT` | string | `0x1234567890abcdef1234567890abcdef12345678` | 接收方地址 | 配置为实际的接收地址 |
| `PRIVATE_KEY` | string | `your_private_key` | 交易私钥 | 配置为实际的私钥（注意安全） |
| `AUTHTOKEN` | string | `your_auth_token` | 认证令牌 | 配置为实际的认证令牌 |

### 6. 服务镜像配置

| 字段名 | 类型 | 默认值 | 说明 | 配置建议 |
|--------|------|--------|------|----------|
| `ETHERMINT_IMAGE` | string | `ghcr.io/qday-io/qday-abel-bridge-committer:sha-3943796` | Committer 服务镜像 | 使用官方推荐镜像版本 |

## 配置注意事项

1. **安全性**：包含私钥、密码等敏感信息的字段需要妥善保管，建议使用环境变量或密钥管理服务。

2. **网络配置**：确保所有 RPC 地址、API 地址等网络配置正确且可访问。

3. **区块链配置**：根据实际部署的区块链网络调整相关配置。

4. **私钥管理**：`B2NODE_PRIVATE_KEY` 和 `PRIVATE_KEY` 等敏感信息应妥善保管，避免泄露。

5. **环境区分**：测试环境和生产环境应使用不同的配置值。

6. **镜像版本**：建议使用稳定的镜像版本，避免使用 latest 标签。

## 配置示例

```bash
# 生产环境配置示例
RPC_URL=https://polygon-mainnet-rpc.com
BLOCKCHAIN=polygon
INIT_BLOCK_NUMBER=50000000
B2NODE_CHAIN_ID=137
B2NODE_GRPC_HOST=your-b2node-server.com
ENDPOINT=https://your-api-server.com
```

## 数据库配置

Committer 服务使用 MySQL 数据库，相关配置在 `docker-compose.yml` 中定义：

- 数据库：`abe_committer`
- 用户名：`root`
- 密码：`root`
- 端口：`3366`

数据库初始化脚本为 `mysql.sql`，包含以下主要表：
- `rollbacks`：回滚记录表
- `sync_blocks`：区块同步表
- `sync_events`：事件同步表
- `sync_tasks`：同步任务表
- `proposal`：提案表
