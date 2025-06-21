# Step-by-step Guide

- [Database](00-db.md)
- [L1](01-l1.md)
- [zkEVM Prover](02-zkevm-prover.md)
- [zkEVM](03-zkevm.md)
- [zkEVM RPC Proxy](04-zkevm-rpc-proxy.md)
- [zkEVM RPC](04-zkevm-rpc.md)




1. create keystore by MNEMONIC
  - read .env to get MNEMONIC
  - create aggregator.keystore,sequencer.keystore by cli

2. start da node 
  - clone https://github.com/qday-io/qday-zkevm-contracts.git and checkout release branch

  - update config file depend on your need

        -  create .env in root directory
         
         Your mnemonic needs to be in the .env file

        - update docker/scripts/deploy_parameters_docker.json

        - update hardhat.config.js
          to add network by your need


  - exec start2.sh in root directory  

  - out dir
    
    You will see 3 files in it： 
     genesis.json,deploy_output.json,deploy_parameters_docker.json

3. start main node for qday

  - update genesis.config.json

  - update node.config.tomal

  - update prover.config.json

  - run by make commond


    **如需要重新一次，因为系统校验root失败并自动更新下了**

4. start rpc node for qday

  - update genesis.config.json

  - update node.config.tomal

  - update prover.config.json

  - run by make commond

     **如需要重新一次，因为系统校验root失败并自动更新下了**
