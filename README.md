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


## Default accounts

Default mnemonic:

```txt
test test test test test test test test test test test zero
```

Please use the account with path `m/44'/60'/0'/0/0` for DA and QDAY.

## Other documents

- [PostgreSQL Replication on Docker Compose](docs/postgres.md)
- [Step-by-step guide](docs/step-by-step/README.md)