// Let's use the contract we deployed on the Rinkeby test network!
// Contract Address: https://rinkeby.etherscan.io/address/0x648a8087721bb3f68d2e9217a55850bfacece905

const contract_address = '0x3Ac71BdF9B36DBBed29eB63E7EB22CB4401f6c1A';

// Compile your contract in remix, then go to the .JSON artifact and ABI will be there.
const abi = [
    {
        "constant": true,
        "inputs": [
            {
                "name": "",
                "type": "address"
            },
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "name": "propertiesMapping",
        "outputs": [
            {
                "name": "ownerAddress",
                "type": "address"
            },
            {
                "name": "ID",
                "type": "uint256"
            },
            {
                "name": "location",
                "type": "string"
            },
            {
                "name": "cost",
                "type": "uint256"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [
            {
                "name": "__propertyHolder",
                "type": "address"
            }
        ],
        "name": "getNoOfProperties",
        "outputs": [
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "totalPropertyCounter",
        "outputs": [
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [
            {
                "name": "_location",
                "type": "string"
            },
            {
                "name": "_cost",
                "type": "uint256"
            }
        ],
        "name": "registerProperty",
        "outputs": [],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [
            {
                "name": "_propertyHolder",
                "type": "address"
            },
            {
                "name": "_index",
                "type": "uint256"
            }
        ],
        "name": "getProperty",
        "outputs": [
            {
                "name": "",
                "type": "string"
            },
            {
                "name": "",
                "type": "uint256"
            },
            {
                "name": "",
                "type": "address"
            },
            {
                "name": "",
                "type": "uint256"
            }
        ],
        "payable": false,
        "stateMutability": "view",
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [
            {
                "name": "_Buyer",
                "type": "address"
            },
            {
                "name": "_ID",
                "type": "uint256"
            }
        ],
        "name": "transferProperty",
        "outputs": [
            {
                "name": "",
                "type": "bool"
            }
        ],
        "payable": false,
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "name": "result",
                "type": "bool"
            }
        ],
        "name": "transferPropertySucces",
        "type": "event"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": false,
                "name": "result",
                "type": "bool"
            }
        ],
        "name": "registerPropertySucces",
        "type": "event"
    }
];

var contract;
var accounts;

window.addEventListener('load', asyncloaded);    
// Function from web3examples. responsible for loading the provider.
async function asyncloaded() {
    web3 = new Web3(Web3.givenProvider); // provider from metamask      
    var result = await web3.eth.requestAccounts().catch(x => console.log(x.message));
    console.log(`web3 is present: ${web3.version}`); // note: use ` (back quote)
    const network = await web3.eth.net.getId().catch((reason) => console.log(`Cannnot find network ${reason}`));
    if (typeof network === 'undefined' || network != 4) { console.log("Please select Rinkeby test network"); return; }
    console.log("Ethereum network: Rinkeby")
    accounts = await web3.eth.getAccounts();
    console.log(accounts[0]); // show current user.
    contract = new web3.eth.Contract(abi, contract_address);
}
window.addEventListener('load', asyncloaded);     

function registerProperty() {

    var address = document.getElementById("address").value;
    var price = document.getElementById("price").value;
    console.log(address,price);
    contract.methods.registerProperty(address,price).send({from: accounts[0]}).then(x => console.log(x));
}

function transferProperty(){


}

