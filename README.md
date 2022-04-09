# Formula Ether

## Description



## Installation Requirements

- Node.js version > 12.0.0: https://nodejs.org/en/download/
- Metamask browser extension: https://metamask.io/

### Ethereum Connection
This client needs access to the UZHETH blockchain, providing an account with some assets available. The client will connect to this chain and
interact with the deployed betting contract to place bets and retrieve winners.
To connect to the UZHETH blockchain the following credentials can be used:
- Networkname: UZHETH
- New RPC-URL: http://130.60.244.246:8545
- Chain ID: 702
- Currency Symbol: UZHETH

More information about the UZHEthereum chain can be found [here](http://130.60.24.79:1234/?network=UZHETH).

Alternatively, your can run Ganache locally. The [contract](https://github.com/janousy/formula-ether/blob/999193c500040612153204c28767041a0845942d/src/contracts/bettingContract.sol) 
can be deployed with e.g. [Remix IDE](remix.ethereum.org) by adding the local Ganache network to Metamask and the selecting `Injected Web3`
as the environment upon deploying the contract.

## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Lints and fixes files
```
npm run lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).
