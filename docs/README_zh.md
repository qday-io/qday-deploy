# Step-by-step Guide


<strong>注意：</strong>链的运营者（Operator）需要执行全部流程,验证者（Validator）仅需要执行第4步。

## 1. 创建 keystore by MNEMONIC
- 读取 .env 获取 MNEMONIC
- 通过 CLI 创建 aggregator.keystore、sequencer.keystore
- 推荐使用脚本自动生成 keystore 文件：

  ```sh
  bash tools/gen-keystore.sh
  ```
  
现在，keystore 文件会被生成并保存在项目根目录下的 `temp_keystore` 目录中。该目录会自动创建，无需手动操作。

根据生成的 keystore 文件，选取其中两个，分别重命名为 aggregator.keystore 和 sequencer.keystore，并放入 data/keystore 目录下。

命令示例：
```sh
[ -d data/keystore ] || mkdir -p data/keystore
cp temp_keystore/1.keystore data/keystore/aggregator.keystore
cp temp_keystore/0.keystore data/keystore/sequencer.keystore
```

## 2. 启动 DA Node（L1 节点）
- 克隆 https://github.com/qday-io/qday-zkevm-contracts.git 并切换到 release 分支
- 按需更新配置文件：
  - 在根目录创建 .env，写入你的 mnemonic
  - 更新 docker/scripts/deploy_parameters_docker.json
  - 更新 hardhat.config.js，按需添加网络
- 在根目录执行 `start2.sh`
- 输出目录 out 下会生成：
  - genesis.json
  - deploy_output.json
  - deploy_parameters_docker.json
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

## 3. 启动 Main Node（主节点）
- 更新配置文件：
  - data/config/test.genesis.config.json
  - data/config/test.node.config.toml
  - data/config/test.prover.config.json
- 启动主节点：
  ```sh
  make main-node
  ```
- 停止主节点：
  ```sh
  make stop-main-node
  ```

> 如需重新初始化，因为系统校验 root 失败并自动更新下了

## 4. 启动 RPC Node
- 更新配置文件：
  - data/config/test.genesis.config.json
  - data/config/test.node.config.toml
  - data/config/test.prover.config.json
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



