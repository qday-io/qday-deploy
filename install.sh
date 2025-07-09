#!/bin/bash

# 1. 检查 Node.js 是否已安装
if ! command -v node >/dev/null 2>&1; then
  echo "Node.js 未安装，正在安装 Node.js..."
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update && sudo apt-get install -y nodejs npm
  elif command -v yum >/dev/null 2>&1; then
    sudo yum install -y nodejs npm
  elif command -v brew >/dev/null 2>&1; then
    brew install node
  else
    echo "请手动安装 Node.js"
    exit 1
  fi
else
  echo "Node.js 已安装，版本: $(node -v)"
fi

# 2. 检查 npm 是否已安装
if ! command -v npm >/dev/null 2>&1; then
  echo "npm 未安装，请检查 Node.js 安装"
  exit 1
fi

# 3. 在根目录下根据 package.json 安装依赖
npm install