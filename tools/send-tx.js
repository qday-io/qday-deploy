#!/usr/bin/env node
const { ethers } = require('ethers');

// ====== 配置区 ======
const privateKey = '0x58cc79556f58a319f5d3f789adc09dd3b968cad744d31319d1e5bea0fab63099'; // 私钥需要0x前缀
const to = '0xfa40DA778Dea669E61E40ae0683559a5E8515657';         // 接收地址
const valueEth = '0.01';                    // 发送金额（ETH）
const rpcUrl = 'http://190.92.213.101:8123'; // RPC URL
// ====================

async function main() {
  try {
    // 检查私钥格式
    if (!privateKey.startsWith('0x')) {
      throw new Error('Private key must start with 0x');
    }

    // 创建 provider (兼容 ethers v5 和 v6)
    let provider;

    provider = new ethers.providers.JsonRpcProvider(rpcUrl);

    const wallet = new ethers.Wallet(privateKey, provider);
    
    // 检查余额
    const balance = await wallet.getBalance();
    console.log('Wallet balance:', ethers.utils.formatEther(balance), 'ETH');
    
    const tx = {
      to,
      value: ethers.utils.parseEther(valueEth)
    };
    
    console.log('Sending transaction:', {
      to: tx.to,
      value: valueEth + ' ETH',
      from: wallet.address
    });
    
    const sentTx = await wallet.sendTransaction(tx);
    console.log('Transaction sent! Hash:', sentTx.hash);
    
    console.log('Waiting for confirmation...');
    await sentTx.wait();
    console.log('Transaction confirmed!');
    
  } catch (error) {
    console.error('Error:', error.message);
    if (error.code === 'INSUFFICIENT_FUNDS') {
      console.error('Insufficient funds in wallet');
    } else if (error.code === 'NETWORK_ERROR') {
      console.error('Network error - check RPC URL');
    }
    process.exit(1);
  }
}

main(); 