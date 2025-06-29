# Indexer 配置文件字段说明

本文档详细说明 indexer 服务配置文件中各个字段的含义、类型、默认值及配置建议。

## 配置分组

### 1. Indexer 基础配置 (indexer.toml)

| 字段名 | 类型 | 默认值 | 说明 | 配置建议 |
|--------|------|--------|------|----------|
| `INDEXER_ROOT_DIR` | string | `./config` | indexer 配置文件根目录 | 保持默认值即可 |
| `INDEXER_LOG_LEVEL` | string | `info` | 日志级别 | 可选：debug, info, warn, error |
| `INDEXER_LOG_FORMAT` | string | `console` | 日志格式 | 可选：console, json |
| `INDEXER_DATABASE_SOURCE` | string | `postgres://abe_user:123456789@pg:5432/abe_indexer?sslmode=disable` | PostgreSQL 数据库连接串 | 根据实际数据库配置修改 |
| `INDEXER_DATABASE_MAX_IDLE_CONNS` | int | `10` | 数据库最大空闲连接数 | 根据并发需求调整 |
| `INDEXER_DATABASE_MAX_OPEN_CONNS` | int | `20` | 数据库最大打开连接数 | 根据并发需求调整 |
| `INDEXER_DATABASE_CONN_MAX_LIFETIME` | int | `3600` | 数据库连接最大生命周期（秒） | 保持默认值即可 |

### 2. Bitcoin 网络配置 (bitcoin.toml)

| 字段名 | 类型 | 默认值 | 说明 | 配置建议 |
|--------|------|--------|------|----------|
| `BITCOIN_NETWORK_NAME` | string | `"Abelian Testnetwork"` | 比特币网络名称 | 根据实际网络修改 |
| `BITCOIN_RPC_HOST` | string | `"testnet-rpc-00.abelian.info"` | 比特币 RPC 主机地址 | 配置为实际的比特币节点地址 |
| `BITCOIN_RPC_PORT` | string | `""` | 比特币 RPC 端口 | 根据实际节点配置 |
| `BITCOIN_RPC_USER` | string | `"J8y0OnkS2wx9XEgUlW5MqtoRDAQ="` | 比特币 RPC 用户名 | 配置为实际的 RPC 用户名 |
| `BITCOIN_RPC_PASS` | string | `"ULlXc/ZMJ375cn6VuSbtU+Y3KGQ="` | 比特币 RPC 密码 | 配置为实际的 RPC 密码 |
| `BITCOIN_DISABLE_TLS` | bool | `false` | 是否禁用 TLS | 生产环境建议保持 false |
| `BITCOIN_WALLET_NAME` | string | `""` | 比特币钱包名称 | 如使用钱包功能则配置 |
| `BITCOIN_ENABLE_INDEXER` | bool | `true` | 是否启用比特币索引器 | 保持默认值 |
| `BITCOIN_INDEXER_LISTEN_ADDRESS` | string | `"abe338ce0ce178fb0aca42b4e400cdf395c92cbf9c5c9abd678aa516835f697bd6d280b285815924f862352c5463421c9f8d247f65dc112aa04c25de925bd1d1a334"` | 索引器监听地址 | 配置为实际的监听地址 |
| `BITCOIN_INDEXER_LISTEN_TARGET_CONFIRMATIONS` | int | `1` | 目标确认数 | 根据安全需求调整 |

### 3. Bitcoin Bridge 配置

| 字段名 | 类型 | 默认值 | 说明 | 配置建议 |
|--------|------|--------|------|----------|
| `BITCOIN_BRIDGE_ETH_RPC_URL` | string | `"http://159.138.82.123:8123"` | 以太坊 RPC URL | 配置为实际的以太坊节点地址 |
| `BITCOIN_BRIDGE_ETH_PRIV_KEY` | string | `""` | 以太坊私钥 | 配置为实际的私钥（注意安全） |
| `BITCOIN_BRIDGE_CONTRACT_ADDRESS` | string | `"0xD7933fd41EB93680Ba615b87eEC99D76aa5E007C"` | 桥接合约地址 | 配置为实际的合约地址 |
| `BITCOIN_BRIDGE_ABI` | string | `"abi.json"` | 合约 ABI 文件路径 | 保持默认值 |
| `BITCOIN_BRIDGE_AA_B2_API` | string | `"https://deposit-test.qday.ninja:9002"` | AA B2 API 地址 | 配置为实际的 API 地址 |
| `BITCOIN_BRIDGE_WITHDRAW_ENABLE_LISTENER` | bool | `false` | 是否启用提现监听器 | 根据需求配置 |
| `BITCOIN_BRIDGE_DEPOSIT` | string | `""` | 存款地址 | 配置为实际的存款地址 |
| `BITCOIN_BRIDGE_WITHDRAW` | string | `""` | 提现地址 | 配置为实际的提现地址 |
| `BITCOIN_BRIDGE_UNISAT_API_KEY` | string | `""` | Unisat API 密钥 | 如使用 Unisat 服务则配置 |
| `BITCOIN_BRIDGE_PUBLICKEYS` | string | `""` | 公钥列表 | 配置为实际的公钥列表 |
| `BITCOIN_BRIDGE_TIME_INTERVAL` | int | `10` | 时间间隔（秒） | 根据业务需求调整 |
| `BITCOIN_BRIDGE_MULTISIG_NUM` | int | `0` | 多签数量 | 根据多签需求配置 |
| `BITCOIN_BRIDGE_ROLLUP_ENABLE_LISTENER` | bool | `false` | 是否启用 Rollup 监听器 | 根据需求配置 |

## 配置注意事项

1. **安全性**：包含私钥、密码等敏感信息的字段需要妥善保管，建议使用环境变量或密钥管理服务。

2. **网络配置**：确保所有 RPC 地址、API 地址等网络配置正确且可访问。

3. **数据库配置**：根据实际数据库部署情况调整连接参数。

4. **性能调优**：根据实际负载情况调整数据库连接池参数。

5. **环境区分**：测试环境和生产环境应使用不同的配置值。

## 配置示例

```bash
# 生产环境配置示例
INDEXER_LOG_LEVEL=info
BITCOIN_NETWORK_NAME="Abelian Mainnet"
BITCOIN_RPC_HOST="your-mainnet-node.com"
BITCOIN_BRIDGE_ETH_RPC_URL="https://your-eth-node.com"
BITCOIN_BRIDGE_CONTRACT_ADDRESS="0xYourContractAddress"
```
