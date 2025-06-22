# QDAY zkEVM Deploy

## Usage

Run the node, which includes the DA node and the QDAY node.

```bash
make run
```

Run the explorer for DA and QDAY.

```bash
make run-explorer-db run-explorer
```

Stop the node and explorer.

```bash
make stop
```

Stop and clean the data.

```bash
make clean
```

## 单独启动 L1 网络

```sh
make da-node
```

该命令会只启动 L1 网络服务。

停止 L1 网络：
```sh
make stop-da-node
```

重启 L1 网络：
```sh
make restart-da-node
```

## Main node

```sh
make main-node
```

停止全节点：
```sh
make stop-main-node
```

## RPC node

```sh
make rpc-node
```

该命令会启动 prover、pool-db、state-db、sync、json-rpc。

停止 RPC 节点：
```sh
make stop-rpc-node
```

重启 RPC 节点：
```sh
make restart-rpc-node
```

## 双 RPC 节点

### RPC 节点 1

启动第一个 RPC 节点：
```sh
make rpc-node-1
```

该命令会启动 prover、pool-db、state-db、event-db、json-rpc，使用端口 8123。

停止第一个 RPC 节点：
```sh
make stop-rpc-node-1
```

重启第一个 RPC 节点：
```sh
make restart-rpc-node-1
```

### RPC 节点 2

启动第二个 RPC 节点：
```sh
make rpc-node-2
```

该命令会启动 prover、pool-db、state-db、event-db、json-rpc，使用端口 8125。

停止第二个 RPC 节点：
```sh
make stop-rpc-node-2
```

重启第二个 RPC 节点：
```sh
make restart-rpc-node-2
```

### 同时管理两个 RPC 节点

同时启动两个 RPC 节点：
```sh
make rpc-nodes
```

同时停止两个 RPC 节点：
```sh
make stop-rpc-nodes
```

同时重启两个 RPC 节点：
```sh
make restart-rpc-nodes
```

测试两个 RPC 节点的连接性：
```sh
make test-rpc-nodes
```

## Set up MetaMask

### Add DA network

```txt
Network Name: DA - local
New RPC URL: http://localhost:8545
Chain ID: 9000
Currency Symbol (optional): (accept default)
Explorer: http://localhost:4000
```

### Add Qday network

```txt
Network Name: QDay - local
New RPC URL: http://localhost:8123
Chain ID: 1001
Currency Symbol (optional): QDAY
Explorer: http://localhost:4001
```

### Add Qday network (RPC 2)

```txt
Network Name: QDay - local 2
New RPC URL: http://localhost:8125
Chain ID: 1001
Currency Symbol (optional): QDAY
Explorer: http://localhost:4001
```

## Default accounts

Default mnemonic:

```txt
test test test test test test test test test test test zero
```

Please use the account with path `m/44'/60'/0'/0/0` for DA and QDAY.

## Other documents

- [PostgreSQL Replication on Docker Compose](docs/postgres.md)
- [Step-by-step guide](docs/step-by-step/README.md)
- [双 RPC 节点使用指南](docs/rpc-nodes-usage.md)