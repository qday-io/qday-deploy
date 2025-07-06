# QDay 部署工具使用说明

本目录包含了 QDay 项目部署和测试过程中使用的各种工具。

## 目录结构

```
tools/
├── batch/                    # 批处理工具
│   ├── batch-util-mac       # macOS 批处理工具
│   ├── batch-utils-linux    # Linux 批处理工具
│   └── config.yaml          # 批处理工具配置文件
├── gen-keystore.sh          # 密钥库生成脚本
├── keystore.js              # 密钥库生成核心逻辑
├── keystore-decrypt.js      # 密钥库解密工具
├── send-tx.js               # 单次交易发送工具
├── send-tx-loop.js          # 循环交易发送工具
└── tool.md                  # 本说明文档
```

## 工具详细说明

### 1. 密钥库生成工具

#### gen-keystore.sh
**功能**: 自动化密钥库生成脚本，用于初始化项目环境和生成密钥库文件。

**使用方法**:
```bash
cd tools
./gen-keystore.sh
```

**前置条件**:
- 项目根目录需要存在 `.env` 文件
- `.env` 文件中需要设置 `MNEMONIC` 环境变量

**功能说明**:
- 自动检查并初始化 npm 项目
- 安装必要的依赖包 (ethers, dotenv)
- 验证 `.env` 文件存在性
- 调用 `keystore.js` 生成密钥库文件

#### keystore.js
**功能**: 核心密钥库生成逻辑，根据助记词为不同角色生成钱包和密钥库文件。

**生成的角色列表**:
1. L1 Deployment Address
2. L1 Trusted sequencer
3. L1 Trusted aggregator
4. L1 Trusted committer
5. L2 Trusted indexer
6. L2 Trusted validator
7. L2 Trusted fund
8. L2 Trusted market
9. L2 Trusted team
10. L2 Trusted investor

**输出内容**:
- 每个角色的地址 (Address)
- 私钥 (Private Key)
- 助记词 (Mnemonic)
- 加密的密钥库文件 (保存到 `temp_keystore/` 目录)

**密钥库密码**: 默认使用 `testonly` 作为加密密码

#### keystore-decrypt.js
**功能**: 解密密钥库文件，提取钱包信息。

**使用方法**:
```bash
node keystore-decrypt.js <keystore-file> <password>
```

**参数说明**:
- `<keystore-file>`: 密钥库文件路径
- `<password>`: 密钥库密码 (默认: testonly)

**输出内容**:
- 钱包地址 (Address)
- 私钥 (Private Key)
- 公钥 (Public Key)

**示例**:
```bash
node keystore-decrypt.js temp_keystore/0.keystore testonly
```

### 2. 交易发送工具

#### send-tx.js
**功能**: 发送单次以太坊交易。

**配置说明**:
在文件顶部修改以下配置参数：
```javascript
const privateKey = '0x...';           // 发送方私钥 (需要0x前缀)
const to = '0x...';                   // 接收方地址
const valueEth = '0.01';              // 发送金额 (ETH)
const rpcUrl = 'http://...:8123';     // RPC 节点地址
```

**使用方法**:
```bash
node send-tx.js
```

**功能特性**:
- 自动检查私钥格式
- 显示钱包余额
- 发送交易并等待确认
- 错误处理和状态提示

#### send-tx-loop.js
**功能**: 循环发送多笔交易，支持压力测试和自动化交易。

**配置说明**:
在文件顶部修改以下配置参数：
```javascript
const privateKey = '0x...';           // 发送方私钥
const to = '0x...';                   // 接收方地址
const valueEth = '0.01';              // 每次发送金额 (ETH)
const rpcUrl = 'http://...:8123';     // RPC 节点地址

// 循环配置
const intervalSeconds = 30;           // 发送间隔 (秒)
const maxTransactions = 10;           // 最大发送次数 (0=无限循环)
const enableRandomAmount = true;      // 是否启用随机金额
const minAmount = 0.001;              // 最小金额 (ETH)
const maxAmount = 0.02;               // 最大金额 (ETH)
```

**使用方法**:
```bash
node send-tx-loop.js
```

**功能特性**:
- 支持固定间隔循环发送
- 可配置最大发送次数
- 支持随机金额发送
- 实时余额检查
- 优雅退出处理 (Ctrl+C)
- 详细的日志输出和时间戳
- 错误重试机制

**控制命令**:
- `Ctrl+C`: 优雅停止循环
- 自动检查余额不足情况

### 3. 批处理工具

#### batch-util-mac / batch-utils-linux
**功能**: 跨平台批处理工具，用于数据库操作和系统管理，支持通过 hash 值进行特定操作。

**使用方法**:
```bash
# macOS
./batch/batch-util-mac -hash=0x...

# Linux
./batch/batch-utils-linux -hash=0x...
```

**参数说明**:
- `-hash string`: 输入要处理的 hash 值（必需参数）

**示例**:
```bash
# 处理特定的交易 hash
./batch/batch-util-mac -hash=0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef

# 处理区块 hash
./batch/batch-util-mac -hash=0xabcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890
```

**功能特性**:
- 支持交易 hash 和区块 hash 处理
- 根据 hash 值在数据库中查找相关信息
- 可能涉及状态数据库和提交者数据库的查询操作

#### config.yaml
**功能**: 批处理工具的配置文件。

**配置内容**:
```yaml
statedb:
  host: "190.92.213.101"
  port: 5432
  user: "state_user"
  password: "state_password"
  dbname: "state_db"
  sslmode: "disable"

committerdb:
  host: "190.92.213.101"
  port: 3366
  user: "root"
  password: "root"
  dbname: "abe_committer"
```

**数据库配置说明**:
- `statedb`: 状态数据库配置 (PostgreSQL)
- `committerdb`: 提交者数据库配置 (MySQL)

## 使用流程示例

### 1. 初始化密钥库
```bash
# 1. 在项目根目录创建 .env 文件
echo "MNEMONIC=your twelve word mnemonic phrase here" > .env

# 2. 生成密钥库
cd tools
./gen-keystore.sh
```

### 2. 解密密钥库文件
```bash
# 解密特定角色的密钥库
node keystore-decrypt.js temp_keystore/0.keystore testonly
```

### 3. 发送测试交易
```bash
# 发送单笔交易
node send-tx.js

# 循环发送交易 (压力测试)
node send-tx-loop.js
```

### 4. 使用批处理工具
```bash
# 根据操作系统选择对应工具，处理特定 hash
./batch/batch-util-mac -hash=0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef    # macOS
./batch/batch-utils-linux -hash=0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef # Linux
```

## 注意事项

1. **安全性**: 
   - 私钥和助记词请妥善保管
   - 生产环境请使用强密码
   - 不要将敏感信息提交到版本控制

2. **网络配置**:
   - 确保 RPC 节点地址正确
   - 检查网络连接和防火墙设置

3. **余额检查**:
   - 发送交易前确保钱包有足够余额
   - 考虑 gas 费用

4. **错误处理**:
   - 工具包含错误处理机制
   - 查看控制台输出了解详细错误信息

5. **权限设置**:
   - 确保脚本文件有执行权限
   - Linux/macOS: `chmod +x gen-keystore.sh`

## 故障排除

### 常见问题

1. **MNEMONIC 未设置**
   ```
   [ERROR] MNEMONIC environment variable not found
   ```
   **解决方案**: 在项目根目录创建 `.env` 文件并设置 MNEMONIC

2. **私钥格式错误**
   ```
   Private key must start with 0x
   ```
   **解决方案**: 确保私钥以 `0x` 开头

3. **余额不足**
   ```
   Insufficient funds in wallet
   ```
   **解决方案**: 向钱包地址转入足够的 ETH

4. **网络连接失败**
   ```
   Network error - check RPC URL
   ```
   **解决方案**: 检查 RPC URL 和网络连接

5. **密钥库解密失败**
   ```
   Failed to decrypt keystore
   ```
   **解决方案**: 检查密码是否正确 (默认: testonly)

6. **批处理工具参数错误**
   ```
   Usage of ./batch-util-mac:
     -hash string
           输入要处理的 hash 值
   ```
   **解决方案**: 确保提供了 `-hash` 参数，格式为 `-hash=0x...`

### 日志级别

工具使用不同的日志级别：
- `[INFO]`: 信息提示
- `[ERROR]`: 错误信息
- `✅`: 成功操作
- `❌`: 失败操作
- `⏳`: 等待状态
- `🚀`: 开始操作
- `🎯`: 目标状态

## 版本信息

- **ethers**: v5
- **Node.js**: 建议 v14+
- **操作系统**: Linux, macOS, Windows (WSL)

## 更新日志

- 初始版本: 基础密钥库生成和交易发送功能
- 支持循环交易发送和压力测试
- 添加批处理工具和配置文件
- 完善错误处理和日志输出
