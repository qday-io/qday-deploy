# QDAY Deploy

## Prerequisites

Review [docs/step-by-step/Prerequisites.md](docs/step-by-step/Prerequisites.md) before deploying: supported OS and hardware (including AMD64), how full proving differs from **mock proving** resource-wise, software expectations, and mock-prover sizing. For a guided setup (including installing Node.js dependencies such as `ethers`), follow the **[step-by-step guide](docs/README_en.md)** starting at sections 1–2.

## Usage

Run the node stack (includes the DA node and the QDAY node).

```bash
make run
```

Run explorers for DA and QDAY.

```bash
make run-explorer-db run-explorer
```

Stop the node and explorer.

```bash
make stop
```

Stop services and wipe local data.

```bash
make clean
```

## DA node (L1) only

```sh
make da-node
```

This starts only the L1 (DA) network services.

Stop the DA / L1 node:

```sh
make stop-da-node
```

Restart the DA / L1 node:

```sh
make restart-da-node
```

## Main node

```sh
make main-node
```

Stop the main node:

```sh
make stop-main-node
```

## RPC node

```sh
make rpc-node
```

This starts `prover`, `pool-db`, `state-db`, `sync`, and `json-rpc`.

Stop the RPC node:

```sh
make stop-rpc-node
```

Restart the RPC node:

```sh
make restart-rpc-node
```

## Dual RPC nodes

### RPC node 1

Start the first RPC node:

```sh
make rpc-node-1
```

This starts `prover`, `pool-db`, `state-db`, `event-db`, and `json-rpc` on port **8123**.

Stop the first RPC node:

```sh
make stop-rpc-node-1
```

Restart the first RPC node:

```sh
make restart-rpc-node-1
```

### RPC node 2

Start the second RPC node:

```sh
make rpc-node-2
```

This starts `prover`, `pool-db`, `state-db`, `event-db`, and `json-rpc` on port **8125**.

Stop the second RPC node:

```sh
make stop-rpc-node-2
```

Restart the second RPC node:

```sh
make restart-rpc-node-2
```

### Run both RPC nodes

Start both:

```sh
make rpc-nodes
```

Stop both:

```sh
make stop-rpc-nodes
```

Restart both:

```sh
make restart-rpc-nodes
```

Connectivity check for both:

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

### Add QDay network

```txt
Network Name: QDay - local
New RPC URL: http://localhost:8123
Chain ID: 1001
Currency Symbol (optional): QDAY
Explorer: http://localhost:4001
```

### Add QDay network (RPC node 2)

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

Use the account at derivation path `m/44'/60'/0'/0/0` for DA and QDay.

## Documentation

- [Step-by-step guide](docs/README_en.md)
- [PostgreSQL replication (Docker Compose)](docs/postgres.md)

Chinese guide: [`docs/README_zh.md`](docs/README_zh.md).
