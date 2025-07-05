#!/usr/bin/env node
const { ethers } = require('ethers');

// ====== 配置区 ======
const privateKey = '58cc79556f58a319f5d3f789adc09dd3b968cad744d31319d1e5bea0fab63099'; // 0x...
const to = '0xfa40DA778Dea669E61E40ae0683559a5E8515657';         // 0x...
const valueEth = '0.01';                    // 发送金额（ETH）
const rpcUrl = 'http://190.92.213.101:8123'; // RPC URL
// ====================

async function main() {
  const provider = new ethers.providers.JsonRpcProvider(rpcUrl);
  const wallet = new ethers.Wallet(privateKey, provider);
  const tx = {
    to,
    value: ethers.utils.parseEther(valueEth)
  };
  console.log('Sending transaction:', tx);
  const sentTx = await wallet.sendTransaction(tx);
  console.log('Transaction sent! Hash:', sentTx.hash);
  await sentTx.wait();
  console.log('Transaction confirmed!');
}

main().catch(e => {
  console.error('Error:', e.message);
  process.exit(1);
}); 