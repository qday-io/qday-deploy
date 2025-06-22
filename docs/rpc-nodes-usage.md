# 双 RPC 节点使用指南

## 概述

本系统支持在同一台机器上同时运行两个独立的 RPC 节点，每个节点都有自己的数据库和 prover 服务。

## 端口分配

### RPC 节点 1
- HTTP RPC: `8123`
- WebSocket: `8133`
- Metrics: `9091`
- Prover MT: `50061`
- Prover Executor: `50071`
- State DB: `5432`
- Pool DB: `5433`
- Event DB: `5435`

### RPC 节点 2
- HTTP RPC: `8125`
- WebSocket: `8135`
- Metrics: `9092`
- Prover MT: `50062`
- Prover Executor: `50072`
- State DB: `5438`
- Pool DB: `5439`
- Event DB: `5440`

## 快速开始

### 1. 启动两个 RPC 节点

```bash
# 同时启动两个 RPC 节点
make rpc-nodes
```

### 2. 验证节点状态

```bash
# 测试两个 RPC 节点的连接性
make test-rpc-nodes
```

### 3. 在 MetaMask 中添加网络

#### RPC 节点 1
```
Network Name: QDay - local
New RPC URL: http://localhost:8123
Chain ID: 1001
Currency Symbol: QDAY
```

#### RPC 节点 2
```
Network Name: QDay - local 2
New RPC URL: http://localhost:8125
Chain ID: 1001
Currency Symbol: QDAY
```

## 单独管理

### RPC 节点 1

```bash
# 启动
make rpc-node-1

# 停止
make stop-rpc-node-1

# 重启
make restart-rpc-node-1
```

### RPC 节点 2

```bash
# 启动
make rpc-node-2

# 停止
make stop-rpc-node-2

# 重启
make restart-rpc-node-2
```

## 配置文件

### RPC 节点 1 配置
- 节点配置: `data/config/rpc1.node.config.toml`
- Prover 配置: `data/config/rpc1.prover.config.json`
- Docker Compose: `docker-compose-rpc1.yml`

### RPC 节点 2 配置
- 节点配置: `data/config/rpc2.node.config.toml`
- Prover 配置: `data/config/rpc2.prover.config.json`
- Docker Compose: `docker-compose-rpc2.yml`

## 数据库

每个 RPC 节点都有独立的数据库：

### RPC 节点 1
- State DB: `data/db/state`
- Pool DB: `data/db/pool`
- Event DB: `data/db/event`

### RPC 节点 2
- State DB: `data/db/state2`
- Pool DB: `data/db/pool2`
- Event DB: `data/db/event2`

## 故障排除

### 检查容器状态

```bash
# 查看所有相关容器
docker ps | grep zkevm

# 查看 RPC 节点 1 的日志
docker logs zkevm-json-rpc-1

# 查看 RPC 节点 2 的日志
docker logs zkevm-json-rpc-2
```

### 检查端口占用

```bash
# 检查端口是否被占用
netstat -tulpn | grep -E ':(8123|8125|8133|8135)'
```

### 重启服务

如果某个节点出现问题，可以单独重启：

```bash
# 重启 RPC 节点 1
make restart-rpc-node-1

# 重启 RPC 节点 2
make restart-rpc-node-2
```

## 性能考虑

- 每个 RPC 节点需要独立的内存和 CPU 资源
- 建议确保机器有足够的内存（至少 8GB）
- 数据库文件会占用额外的磁盘空间
- 两个节点可以同时处理不同的请求，提高整体吞吐量

## 注意事项

1. 两个 RPC 节点是完全独立的，不会共享状态
2. 每个节点都有自己的数据库，数据不会同步
3. 如果需要数据同步，需要额外的同步机制
4. 确保防火墙允许相关端口的访问
5. 在生产环境中，建议使用负载均衡器来分发请求 