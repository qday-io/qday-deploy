const { ethers, HDNodeWallet } = require("ethers");
const fs = require("fs");
const path = require("path");
require("dotenv").config({ path: path.resolve(process.cwd(), ".env") });

const DEFAULT_KEYSTORE_PASSWORD = "testonly";

async function main() {
  const arrayNames = [
    "## L1 Deployment Address",
    "##L1 Trusted sequencer",
    "##L1 Trusted aggregator",
    "##L1 Trusted committer",
    "##L2 Trusted indexer",
    "##L2 Trusted validator",
    "##L2 Trusted fund",
    "##L2 Trusted market",
    "##L2 Trusted team",
    "##L2 Trusted investor",
  ];

  const mnemonic = process.env.MNEMONIC;
  const keystoreDir = path.resolve(process.cwd(), "temp_keystore");
  if (!fs.existsSync(keystoreDir)) {
    fs.mkdirSync(keystoreDir);
  }

  if (!mnemonic) {
    console.error("[ERROR] MNEMONIC environment variable not found in .env file at project root. Please set MNEMONIC in your .env file.");
    process.exit(1);
  }

  // 用助记词为每个角色推导钱包并生成 keystore 文件（ethers v6 兼容写法）
  for (let i = 0; i < arrayNames.length; i++) {
    const hdPath = `m/44'/60'/0'/0/${i}`;
    const hdNode = HDNodeWallet.fromPhrase(mnemonic, hdPath);
    const wallet = new ethers.Wallet(hdNode.privateKey);
    console.log(arrayNames[i]);
    console.log(`Address: ${wallet.address}`);
    console.log(`PrvKey: ${wallet.privateKey}`);
    console.log(`mnemonic: \"${mnemonic}\"`);
    const keystoreJson = await wallet.encrypt(DEFAULT_KEYSTORE_PASSWORD);
    const filePath = path.join(keystoreDir, `${i}.keystore`);
    fs.writeFileSync(filePath, keystoreJson);
    console.log(`keystore saved: ${filePath}`);
    console.log("\n\n");
  }
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
}); 