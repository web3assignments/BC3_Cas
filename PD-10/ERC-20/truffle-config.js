const HDWalletProvider = require('@truffle/hdwallet-provider');
const fs = require('fs');
const mnemonic = "early mutual inflict divide simple moon eternal consider moral adjust ketchup spy"; // contains mnemonic
const infuraKey = "c94a7ff50fb248fe91b93eca4a395a8b"; // infura key
const etherscanKey = "JVKK9XY77IIHPDMV5VJ19F5E29ZPXSZU5K"; // etherscan key

module.exports = {
    networks: {
     development: {
      host: "127.0.0.1",     // Localhost (default: none)
      port: 7545,            // Standard Ethereum port (default: none)
      network_id: "*",       // Any network (default: none)
    },
    rinkeby: {
        provider: () => new HDWalletProvider(mnemonic, `https://rinkeby.infura.io/v3/${infuraKey}`),
        network_id: 4,       // rinkeby id
        skipDryRun: true
    }
  },
    mocha: { },
    compilers: { solc: { version: "^0.7.6"} },
    plugins: [
        'truffle-plugin-verify'
    ],
    api_keys: {
        etherscan: etherscanKey
    }
}