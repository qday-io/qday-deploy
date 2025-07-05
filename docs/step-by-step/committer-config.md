# Committer Configuration File Field Description

This document details the meaning, type, default value, and configuration suggestions for each field in the committer service configuration file.

## Configuration Groups

### 1. Basic Blockchain Configuration

| Field Name           | Type    | Default Value                                      | Description                        | Configuration Suggestion                  |
|----------------------|---------|----------------------------------------------------|------------------------------------|-------------------------------------------|
| `RPC_URL`            | string  | `http://190.92.213.101:8545`                       | Blockchain RPC node address        | Set to an actual available RPC node       |
| `BLOCKCHAIN`         | string  | `da-node`                                          | Blockchain network name            | Modify according to actual network (e.g., polygon, ethereum) |
| `INIT_BLOCK_NUMBER`  | int     | `1`                                                | Initial sync block number          | Set to the block height to start syncing  |
| `INIT_BLOCK_HASH`    | string  | `0x1db9fbef276c30cc9fdfba2a21d7cc4dd760fd2e76b8906571c6f56a706624bc` | Initial block hash                 | Set to the hash of the corresponding block|
| `POLYGON_ZKEVM_ADDRESS` | string | `0x59C123c2901245F3A38E009Eb341d34CC4609a8E`      | Polygon zkEVM contract address     | Set to the actual zkEVM contract address  |

### 2. Proposal and Batch Configuration

| Field Name                | Type | Default Value | Description                | Configuration Suggestion         |
|---------------------------|------|--------------|----------------------------|----------------------------------|
| `PROPOSAL_BATCHES_LIMITNUM` | int | `2`         | Proposal batch limit       | Adjust according to business needs|
| `INIT_PROPOSAL_ID`        | int  | `1`          | Initial proposal ID        | Set to the starting proposal ID  |

### 3. B2Node Node Configuration

| Field Name           | Type      | Default Value                                      | Description                | Configuration Suggestion         |
|----------------------|-----------|----------------------------------------------------|----------------------------|----------------------------------|
| `B2NODE_PRIVATE_KEY` | string    | `2ee789a68207020b45607f5adb71933de0946baebbaaab74af7cbd69c8a90573` | B2Node private key         | Set to the actual private key (keep secure) |
| `B2NODE_ADDRESS`     | string    | `ethm17nhkv58y35ye5jtjafd5zndtsmsenz7nlxh60c`      | B2Node address             | Set to the corresponding public address     |
| `B2NODE_CHAIN_ID`    | int/string| `ethermint_9000-1`                                 | B2Node chain ID            | Set according to the actual network         |
| `B2NODE_GRPC_HOST`   | string    | `190.92.213.101`                                  | B2Node gRPC host address   | Set to the actual gRPC service address      |
| `B2NODE_GRPC_PORT`   | int       | `9090`                                            | B2Node gRPC port           | Set to the actual gRPC port                 |
| `B2NODE_COIN_DENOM`  | string    | `aphoton`                                         | B2Node coin symbol         | Set to the actual coin symbol               |

- Build for B2NODE_ADDRESS
```sh
# Enter the da node container service
ethermintd keys show mykey --keyring-backend test -a
ethm17nhkv58y35ye5jtjafd5zndtsmsenz7nlxh60c
```

- Build for B2NODE_PRIVATE_KEY
```sh
# Enter the da node container service
ethermintd keys export mykey --unarmored-hex --unsafe --keyring-backend test

2ee789a68207020b45607f5adb71933de0946baebbaaab74af7cbd69c8a90573
```

### 4. API and Authentication Configuration

| Field Name         | Type    | Default Value                                      | Description                | Configuration Suggestion         |
|--------------------|---------|----------------------------------------------------|----------------------------|----------------------------------|
| `ENDPOINT`         | string  | `https://testnet-snode.pqabelian.io/v1/single-account` | API endpoint address       | Set to the actual API service address |
| `RPCENDPOINT`      | string  | `https://testnet-rpc-00.pqabelian.io`              | RPC endpoint address       | Set to the actual RPC service address |
| `USERNAME`         | string  | `J8y0OnkS2wx9XEgUlW5MqtoRDAQ=`                     | API username               | Set to the actual username           |
| `PASSWORD`         | string  | `ULlXc/ZMJ375cn6VuSbtU+Y3KGQ=`                     | API password               | Set to the actual password (keep secure) |
| `APPID`            | string  | `8b9ca2d7`                                         | Application ID             | Set to the actual application ID        |
| `REQUEST_SIGNATURE`| string  | `0x338i3jejjd`                                     | Request signature          | Set to the actual signature key         |
| `AUTHTOKEN`        | string  | `cce71078669ded3517d961a2d57eb440`                 | Authentication token       | Set to the actual authentication token  |

### 5. Transaction Configuration

| Field Name         | Type    | Default Value                                      | Description                | Configuration Suggestion         |
|--------------------|---------|----------------------------------------------------|----------------------------|----------------------------------|
| `FROM`             | string  | `abe3238c46312425ffffd1250f3a7024ff31ad8d15fc6eeb5ad38962115640e59e94e8da112a82192d90e66539eea6427c9fb052b27ae534c8f2835b8d9c12adc1ac` | Sender address             | Set to the actual sender address      |
| `RECIPIENT`        | string  | `abe338491ef250a530f6b1a771d45ae168f81d6a430f20623849e448b870f0f95e13f12ba51bff83497480db944567750e3cf555cd9811db95b848ca93d45c1448d0` | Recipient address          | Set to the actual recipient address   |
| `PRIVATE_KEY`      | string  | `00000000df5dbe326a891678dce65726de3bc83676835472826a911291520115d7bcf22d2b5ee9836a81defcadd8a656bbeaea33fb53f482dac90c330356d6faee92056fbc8b49d0ac2b3af022821d6f2b60b43ccc0830260291f7506e335e5cd6692c1e0c77d2903015c47b5d3c3bee0b0ef5c7d86e1ebcab0879a8400cffeb4a713bd0` | Transaction private key    | Set to the actual private key (keep secure) |
| `USERID`           | string  | `abe3238c46312425ffffd1250f3a7024ff31ad8d15fc6eeb5ad38962115640e59e94e8da112a82192d90e66539eea6427c9fb052b27ae534c8f2835b8d9c12adc1ac` | User ID                    | Set to the actual user ID                 |

### 6. Service Image Configuration

| Field Name         | Type    | Default Value                                      | Description                | Configuration Suggestion         |
|--------------------|---------|----------------------------------------------------|----------------------------|----------------------------------|
| `ETHERMINT_IMAGE`  | string  | `ghcr.io/qday-io/qday-abel-bridge-committer:sha-e26ddc5` | Committer service image    | Use the officially recommended image version |

Reference Example:

```
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
```
