#!/usr/bin/env node
const { ethers } = require('ethers');

// ====== 配置区 ======
const privateKey = '0x58cc79556f58a319f5d3f789adc09dd3b968cad744d31319d1e5bea0fab63099'; // 私钥需要0x前缀
const to = '0xfa40DA778Dea669E61E40ae0683559a5E8515657';         // 接收地址
const valueEth = '0.01';                    // 每次发送金额（ETH）
const rpcUrl = 'http://190.92.213.101:8123'; // RPC URL

// 循环配置
const intervalSeconds = 30;                  // 发送间隔（秒）
const maxTransactions = 10;                 // 最大发送次数（0表示无限循环）
const enableRandomAmount = true;            // 是否启用随机金额
const minAmount = 0.001;                    // 最小金额（ETH）
const maxAmount = 0.02;                     // 最大金额（ETH）
// ====================

let transactionCount = 0;
let isRunning = true;

// 生成随机金额
function getRandomAmount() {
  if (!enableRandomAmount) return valueEth;
  const random = Math.random() * (maxAmount - minAmount) + minAmount;
  return random.toFixed(6);
}

// 格式化时间
function formatTime() {
  return new Date().toLocaleString('zh-CN');
}

// 格式化间隔时间显示
function formatInterval(seconds) {
  if (seconds < 60) {
    return `${seconds}秒`;
  } else if (seconds < 3600) {
    const minutes = Math.floor(seconds / 60);
    const remainingSeconds = seconds % 60;
    return remainingSeconds > 0 ? `${minutes}分${remainingSeconds}秒` : `${minutes}分钟`;
  } else {
    const hours = Math.floor(seconds / 3600);
    const remainingMinutes = Math.floor((seconds % 3600) / 60);
    const remainingSeconds = seconds % 60;
    let result = `${hours}小时`;
    if (remainingMinutes > 0) result += `${remainingMinutes}分钟`;
    if (remainingSeconds > 0) result += `${remainingSeconds}秒`;
    return result;
  }
}

// 发送单笔交易
async function sendTransaction() {
  try {
    // 检查私钥格式
    if (!privateKey.startsWith('0x')) {
      throw new Error('Private key must start with 0x');
    }

    const provider = new ethers.providers.JsonRpcProvider(rpcUrl);
    const wallet = new ethers.Wallet(privateKey, provider);
    
    // 检查余额
    const balance = await wallet.getBalance();
    const balanceEth = ethers.utils.formatEther(balance);
    console.log(`[${formatTime()}] Wallet balance: ${balanceEth} ETH`);
    
    // 检查余额是否足够
    const currentAmount = getRandomAmount();
    const requiredAmount = ethers.utils.parseEther(currentAmount);
    if (balance.lt(requiredAmount)) {
      console.log(`[${formatTime()}] ❌ Insufficient balance for ${currentAmount} ETH`);
      return false;
    }
    
    const tx = {
      to,
      value: requiredAmount
    };
    
    console.log(`[${formatTime()}] 🚀 Sending transaction #${transactionCount + 1}:`);
    console.log(`   From: ${wallet.address}`);
    console.log(`   To: ${tx.to}`);
    console.log(`   Amount: ${currentAmount} ETH`);
    
    const sentTx = await wallet.sendTransaction(tx);
    console.log(`[${formatTime()}] ✅ Transaction sent! Hash: ${sentTx.hash}`);
    
    console.log(`[${formatTime()}] ⏳ Waiting for confirmation...`);
    await sentTx.wait();
    console.log(`[${formatTime()}] ✅ Transaction confirmed!`);
    
    transactionCount++;
    return true;
    
  } catch (error) {
    console.error(`[${formatTime()}] ❌ Error:`, error.message);
    if (error.code === 'INSUFFICIENT_FUNDS') {
      console.error(`[${formatTime()}] 💡 Insufficient funds in wallet`);
    } else if (error.code === 'NETWORK_ERROR') {
      console.error(`[${formatTime()}] 🌐 Network error - check RPC URL`);
    } else if (error.code === 'NONCE_EXPIRED') {
      console.error(`[${formatTime()}] 🔄 Nonce expired, retrying...`);
    }
    return false;
  }
}

// 主循环函数
async function mainLoop() {
  console.log(`[${formatTime()}] 🎯 Starting transaction loop`);
  console.log(`[${formatTime()}] 📊 Configuration:`);
  console.log(`   Interval: ${formatInterval(intervalSeconds)}`);
  console.log(`   Max transactions: ${maxTransactions === 0 ? 'Infinite' : maxTransactions}`);
  console.log(`   Random amount: ${enableRandomAmount ? 'Enabled' : 'Disabled'}`);
  if (enableRandomAmount) {
    console.log(`   Amount range: ${minAmount} - ${maxAmount} ETH`);
  } else {
    console.log(`   Fixed amount: ${valueEth} ETH`);
  }
  console.log(`[${formatTime()}] 🔄 Starting in 5 seconds...\n`);
  
  // 等待5秒开始
  await new Promise(resolve => setTimeout(resolve, 5000));
  
  while (isRunning) {
    try {
      // 检查是否达到最大次数
      if (maxTransactions > 0 && transactionCount >= maxTransactions) {
        console.log(`[${formatTime()}] 🎉 Reached maximum transactions (${maxTransactions})`);
        break;
      }
      
      // 发送交易
      const success = await sendTransaction();
      
      if (success) {
        console.log(`[${formatTime()}] 📈 Progress: ${transactionCount}/${maxTransactions === 0 ? '∞' : maxTransactions}\n`);
      }
      
      // 等待下次发送
      if (isRunning && (maxTransactions === 0 || transactionCount < maxTransactions)) {
        console.log(`[${formatTime()}] ⏰ Waiting ${formatInterval(intervalSeconds)} for next transaction...`);
        await new Promise(resolve => setTimeout(resolve, intervalSeconds * 1000));
      }
      
    } catch (error) {
      console.error(`[${formatTime()}] ❌ Loop error:`, error.message);
      // 出错后等待1分钟再重试
      await new Promise(resolve => setTimeout(resolve, 60 * 1000));
    }
  }
  
  console.log(`[${formatTime()}] 🏁 Transaction loop stopped`);
  console.log(`[${formatTime()}] 📊 Total transactions sent: ${transactionCount}`);
}

// 优雅退出处理
process.on('SIGINT', () => {
  console.log(`\n[${formatTime()}] 🛑 Received SIGINT, stopping gracefully...`);
  isRunning = false;
  setTimeout(() => {
    console.log(`[${formatTime()}] 👋 Goodbye!`);
    process.exit(0);
  }, 2000);
});

process.on('SIGTERM', () => {
  console.log(`\n[${formatTime()}] 🛑 Received SIGTERM, stopping gracefully...`);
  isRunning = false;
  setTimeout(() => {
    console.log(`[${formatTime()}] 👋 Goodbye!`);
    process.exit(0);
  }, 2000);
});

// 启动主循环
mainLoop().catch(error => {
  console.error(`[${formatTime()}] 💥 Fatal error:`, error.message);
  process.exit(1);
}); 