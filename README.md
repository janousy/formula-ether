# Formula Ether

## Description



## Installation Requirements

- Node.js version > 12.0.0: https://nodejs.org/en/download/
- Metamask browser extension: https://metamask.io/

### Ethereum Connection
This client needs access to the UZHETH blockchain, providing an account with some assets available. It client will connect to this chain and
interact with the deployed betting contract to place bets and retrieve winners.

Alternatively, your can run Ganache locally. The [contarct](https://github.com/janousy/formula-ether/blob/999193c500040612153204c28767041a0845942d/src/contracts/bettingContract.sol) 
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
