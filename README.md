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