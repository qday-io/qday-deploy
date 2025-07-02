# Committer 配置文件字段说明

本文档详细说明 committer 服务配置文件中各个字段的含义、类型、默认值及配置建议。

## 配置分组

### 1. 区块链基础配置

| 字段名 | 类型 | 默认值 | 说明 | 配置建议 |
|--------|------|--------|------|----------|
| `RPC_URL` | string | `http://190.92.213.101:8545` | 区块链 RPC 节点地址 | 配置为实际可用的 RPC 节点 |
| `BLOCKCHAIN` | string | `da-node` | 区块链网络名称 | 根据实际网络修改（如：polygon, ethereum） |
| `INIT_BLOCK_NUMBER` | int | `1` | 初始同步区块号 | 配置为开始同步的区块高度 |
| `INIT_BLOCK_HASH` | string | `0x1db9fbef276c30cc9fdfba2a21d7cc4dd760fd2e76b8906571c6f56a706624bc` | 初始区块哈希 | 配置为对应区块的哈希值 |
| `POLYGON_ZKEVM_ADDRESS` | string | `0x59C123c2901245F3A38E009Eb341d34CC4609a8E` | Polygon zkEVM 合约地址 | 配置为实际的 zkEVM 合约地址 |

### 2. 提案和批次配置

| 字段名 | 类型 | 默认值 | 说明 | 配置建议 |
|--------|------|--------|------|----------|
| `PROPOSAL_BATCHES_LIMITNUM` | int | `2` | 提案批次限制数量 | 根据业务需求调整 |
| `INIT_PROPOSAL_ID` | int | `1` | 初始提案 ID | 配置为开始处理的提案 ID |

### 3. B2Node 节点配置

| 字段名 | 类型 | 默认值 | 说明 | 配置建议 |
|--------|------|--------|------|----------|
| `B2NODE_PRIVATE_KEY` | string | `2ee789a68207020b45607f5adb71933de0946baebbaaab74af7cbd69c8a90573` | B2Node 私钥 | 配置为实际的私钥（注意安全） |
| `B2NODE_ADDRESS` | string | `ethm17nhkv58y35ye5jtjafd5zndtsmsenz7nlxh60c` | B2Node 地址 | 配置为对应的公钥地址 |
| `B2NODE_CHAIN_ID` | int/string | `ethermint_9000-1` | B2Node 链 ID | 根据实际网络配置 |
| `B2NODE_GRPC_HOST` | string | `190.92.213.101` | B2Node gRPC 主机地址 | 配置为实际的 gRPC 服务地址 |
| `B2NODE_GRPC_PORT` | int | `9090` | B2Node gRPC 端口 | 配置为实际的 gRPC 端口 |
| `B2NODE_RPC_URL` | string | `http://190.92.213.101:9090` | B2Node RPC URL | 配置为实际的 RPC 地址 |
| `B2NODE_COIN_DENOM` | string | `aphoton` | B2Node 代币名称 | 配置为实际的代币符号 |


- build for B2NODE_ADDRESS
```
//Enter the da node container service
ethermintd keys show mykey --keyring-backend test -a
ethm17nhkv58y35ye5jtjafd5zndtsmsenz7nlxh60c
```

- build for B2NODE_PRIVATE_KEY
```
//Enter the da node container service
ethermintd keys export mykey --unarmored-hex --unsafe --keyring-backend test

2ee789a68207020b45607f5adb71933de0946baebbaaab74af7cbd69c8a90573
```


### 4. API 和认证配置

| 字段名 | 类型 | 默认值 | 说明 | 配置建议 |
|--------|------|--------|------|----------|
| `ENDPOINT` | string | `https://testnet-snode.pqabelian.io/v1/single-account` | API 端点地址 | 配置为实际的 API 服务地址 |
| `RPCENDPOINT` | string | `https://testnet-rpc-00.pqabelian.io` | RPC 端点地址 | 配置为实际的 RPC 服务地址 |
| `USERNAME` | string | `J8y0OnkS2wx9XEgUlW5MqtoRDAQ=` | API 用户名 | 配置为实际的用户名 |
| `PASSWORD` | string | `ULlXc/ZMJ375cn6VuSbtU+Y3KGQ=` | API 密码 | 配置为实际的密码（注意安全） |
| `APPID` | string | `8b9ca2d7` | 应用 ID | 配置为实际的应用标识 |
| `REQUEST_SIGNATURE` | string | `0x338i3jejjd` | 请求签名 | 配置为实际的签名密钥 |
| `AUTHTOKEN` | string | `cce71078669ded3517d961a2d57eb440` | 认证令牌 | 配置为实际的认证令牌 |

### 5. 交易配置

| 字段名 | 类型 | 默认值 | 说明 | 配置建议 |
|--------|------|--------|------|----------|
| `FROM` | string | `abe3238c46312425ffffd1250f3a7024ff31ad8d15fc6eeb5ad38962115640e59e94e8da112a82192d90e66539eea6427c9fb052b27ae534c8f2835b8d9c12adc1ac` | 发送方地址 | 配置为实际的发送地址 |
| `RECIPIENT` | string | `abe338491ef250a530f6b1a771d45ae168f81d6a430f20623849e448b870f0f95e13f12ba51bff83497480db944567750e3cf555cd9811db95b848ca93d45c1448d0` | 接收方地址 | 配置为实际的接收地址 |
| `PRIVATE_KEY` | string | `00000000df5dbe326a891678dce65726de3bc83676835472826a911291520115d7bcf22d2b5ee9836a81defcadd8a656bbeaea33fb53f482dac90c330356d6faee92056fbc8b49d0ac2b3af022821d6f2b60b43ccc0830260291f7506e335e5cd6692c1e0c77d2903015c47b5d3c3bee0b0ef5c7d86e1ebcab0879a8400cffeb4a713bd0` | 交易私钥 | 配置为实际的私钥（注意安全） |
| `USERID` | string | `abe3238c46312425ffffd1250f3a7024ff31ad8d15fc6eeb5ad38962115640e59e94e8da112a82192d90e66539eea6427c9fb052b27ae534c8f2835b8d9c12adc1ac` | 用户 ID | 配置为实际的用户标识 |


### 6. 服务镜像配置

| 字段名 | 类型 | 默认值 | 说明 | 配置建议 |
|--------|------|--------|------|----------|
| `ETHERMINT_IMAGE` | string | `ghcr.io/qday-io/qday-abel-bridge-committer:sha-e26ddc5` | Committer 服务镜像 | 使用官方推荐镜像版本 |


参考案例：

ETHERMINT_IMAGE=ghcr.io/qday-io/qday-abel-bridge-committer:sha-e26ddc5
RPC_URL=http://190.92.213.101:8545
BLOCKCHAIN=da-node
INIT_BLOCK_NUMBER=1
INIT_BLOCK_HASH=0x1db9fbef276c30cc9fdfba2a21d7cc4dd760fd2e76b8906571c6f56a706624bc
POLYGON_ZKEVM_ADDRESS=0x59C123c2901245F3A38E009Eb341d34CC4609a8E
PROPOSAL_BATCHES_LIMITNUM=2
INIT_PROPOSAL_ID=1
B2NODE_PRIVATE_KEY=2ee789a68207020b45607f5adb71933de0946baebbaaab74af7cbd69c8a90573
B2NODE_ADDRESS=ethm17nhkv58y35ye5jtjafd5zndtsmsenz7nlxh60c
B2NODE_CHAIN_ID=ethermint_9000-1
B2NODE_GRPC_HOST=190.92.213.101
B2NODE_GRPC_PORT=9090
B2NODE_RPC_URL=http://190.92.213.101:9090
B2NODE_COIN_DENOM=aphoton
ENDPOINT=https://testnet-snode.pqabelian.io/v1/single-account
RPCENDPOINT=https://testnet-rpc-00.pqabelian.io
USERNAME=J8y0OnkS2wx9XEgUlW5MqtoRDAQ=
PASSWORD=ULlXc/ZMJ375cn6VuSbtU+Y3KGQ=
AUTHTOKEN=cce71078669ded3517d961a2d57eb440
APPID=8b9ca2d7
REQUEST_SIGNATURE=0x338i3jejjd
USERID=abe3238c46312425ffffd1250f3a7024ff31ad8d15fc6eeb5ad38962115640e59e94e8da112a82192d90e66539eea6427c9fb052b27ae534c8f2835b8d9c12adc1ac
FROM=abe3238c46312425ffffd1250f3a7024ff31ad8d15fc6eeb5ad38962115640e59e94e8da112a82192d90e66539eea6427c9fb052b27ae534c8f2835b8d9c12adc1ac
RECIPIENT=abe338491ef250a530f6b1a771d45ae168f81d6a430f20623849e448b870f0f95e13f12ba51bff83497480db944567750e3cf555cd9811db95b848ca93d45c1448d0
PRIVATE_KEY=00000000df5dbe326a891678dce65726de3bc83676835472826a911291520115d7bcf22d2b5ee9836a81defcadd8a656bbeaea33fb53f482dac90c330356d6faee92056fbc8b49d0ac2b3af022821d6f2b60b43ccc0830260291f7506e335e5cd6692c1e0c77d2903015c47b5d3c3bee0b0ef5c7d86e1ebcab0879a8400cffeb4a713bd0
