
const { ethers }  = require('ethers');

const mnemonic = "print huge discover staff interest change reveal humor tribe grocery virtual poem clump fringe color";
const hdNode = ethers.HDNodeWallet.fromPhrase(mnemonic);

const secondAccount = hdNode.derivePath(`m/44'/60'/0'/0/1`);
const thirdAccount = hdNode.derivePath(`m/44'/60'/0'/0/2`);

console.log(secondAccount.address);
console.log(thirdAccount.address);