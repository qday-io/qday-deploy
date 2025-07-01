#!/usr/bin/env node
const fs = require('fs');
const path = require('path');
const { ethers } = require('ethers');

if (process.argv.length < 4) {
  console.log('Usage: node keystore-decrypt.js <keystore-file> <password>');
  process.exit(1);
}

const keystorePath = process.argv[2];
const password = process.argv[3];

async function main() {
  if (!fs.existsSync(keystorePath)) {
    console.error('Keystore file not found:', keystorePath);
    process.exit(1);
  }
  const keystoreJson = fs.readFileSync(keystorePath, 'utf8');
  try {
    const wallet = await ethers.Wallet.fromEncryptedJson(keystoreJson, password);
    console.log('Address:', wallet.address);
    console.log('Private Key:', wallet.privateKey);
    console.log('Public Key:', wallet.publicKey);
  } catch (e) {
    console.error('Failed to decrypt keystore:', e.message);
    process.exit(1);
  }
}

main(); 