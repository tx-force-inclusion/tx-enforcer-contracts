# TxEnforcerV1

Smart contract designed to interact with **Superchain Layer 2s** that utilize the **OptimismPortal**. This contract enables users to force-include transactions on supported Layer 2 chains by interacting with their respective messaging contract on Layer 1.

This project uses the [Foundry framework](https://github.com/foundry-rs/foundry) for testing and deployment.

## Disclaimer

⚠️ Proof of Concept (PoC): Use with Caution

This contract is a PoC and has not been audited for security. It is intended for experimental and educational purposes only. Users should exercise caution when deploying or interacting with this contract in production environments.

## Deployment Addresses

- `Mainnet`: [0x6A20DAA469A26aF06BDC012147996030BB08106F](https://etherscan.io/address/0x6A20DAA469A26aF06BDC012147996030BB08106F#code)
- `Sepolia`: [0xb2382eA48E00F6cB56663d8EEE9c7c68Cd21AB9B](https://sepolia.etherscan.io/address/0xb2382eA48E00F6cB56663d8EEE9c7c68Cd21AB9B#code)

## Table of Contents

- [About](#about)
- [Getting Started](#getting-started)
  - [Requirements](#requirements)
  - [Quickstart](#quickstart)
- [Usage](#usage)
  - [Start a Local Node](#start-a-local-node)
  - [Deploy](#deploy)
  - [Deploy to Other Networks](#deploy-to-other-networks)
- [Interactions](#interactions)
- [Formatting](#formatting)
- [Static Analysis](#static-analysis)
- [Disclaimer](#disclaimer)
- [License](#license)
- [Author](#author)

## About

TxEnforcerV1 is a proof-of-concept (PoC) contract that forwards user requests into the **OptimismPortal's** `depositTransaction` function. It supports forwarding transactions to specific Layer 2 addresses, transferring ETH, and emitting events for transparency.

This contract is the first version, supporting Superchain Layer 2s using the OptimismPortal. Future versions will include support for additional Layer 2 clusters.

## Getting Started

### Requirements

- Git: [Download](https://git-scm.com/downloads)
  - Verify installation: `git --version`
- Foundry: [Installation Guide](https://book.getfoundry.sh/getting-started/installation)
  - Verify installation: `forge --version`

### Quickstart

Clone the repository and build the project:

```bash
git clone https://github.com/tx-force-inclusion/tx-enforcer-contracts.git
cd tx-enforcer-v1
forge install
forge build
```

## Usage

### Start a Local Node

Start a local Ethereum node for testing using Anvil (included with Foundry):

```bash
anvil
```

### Deploy

In a separate terminal, deploy the contract to your local node:

```bash
forge script script/DeployTxEnforcerV1.s.sol:DeployTxEnforcerV1 --fork-url http://localhost:8545 --broadcast
```

### Deploy to Other Networks

To deploy to networks like Sepolia or Mainnet, specify the network in the deploy script and provide the necessary RPC URLs and private keys.

```bash
forge script script/Deploy.s.sol:DeployTxEnforcerV1 --rpc-url $(SEPOLIA_RPC_URL) --account $(SEPOLIA_ACCOUNT) --broadcast --verify --etherscan-api-key $(ETHERSCAN_API_KEY)
```

### Setup Environment Variables

Create a .env file and set the following variables:

- `PRIVATE_KEY`: Your private key (ensure it is for a test account).
- `SEPOLIA_RPC_URL` or `MAINNET_RPC_URL`: RPC URL for the network.
- `ETHERSCAN_API_KEY` (optional): For contract verification.

## Interactions

Interact with the deployed contract using `cast` commands.

Examples:

- Forward a transaction to Layer 2:

```bash
cast send <contract_address> "forwardDepositTx(address,address,uint256,uint64,bool,bytes)" <portal_address> <to_address> <value> <gas_limit> <is_creation> <calldata> --private-key $(PRIVATE_KEY) --rpc-url $(RPC_URL)
```

## Formatting

Ensure code is formatted correctly:

```bash
forge fmt
```

## Static Analysis

Run [Slither](https://github.com/crytic/slither) for static analysis:

```bash
slither .
```

## License

This project is licensed under the MIT License.
