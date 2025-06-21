#!/bin/bash

# 进入脚本所在目录
cd "$(dirname "$0")"

# 项目根目录
ROOT_DIR="$(cd ../ && pwd)"
cd "$ROOT_DIR"

# 检查 package.json 是否存在，不存在则初始化
if [ ! -f "package.json" ]; then
  echo "[INFO] Initializing npm project..."
  npm init -y
fi

# 检查 node_modules/ethers 是否存在，不存在则安装依赖
if [ ! -d "node_modules/ethers" ] || [ ! -d "node_modules/dotenv" ]; then
  echo "[INFO] Installing npm dependencies..."
  npm install ethers dotenv
fi

# 检查 .env 是否存在
if [ ! -f ".env" ]; then
  echo "[ERROR] .env file not found in project root. Please create and set MNEMONIC."
  exit 1
fi

# 执行 keystore.js
node tools/keystore.js 