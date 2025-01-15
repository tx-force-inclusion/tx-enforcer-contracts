-include .env

.PHONY: all test clean deploy fund help install snapshot format anvil zktest

DEFAULT_ANVIL_KEY := 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80

all: clean remove install update build

# Clean the repo
clean  :; forge clean

# Remove modules
remove :; rm -rf .gitmodules && rm -rf .git/modules/* && rm -rf lib && touch .gitmodules && git add . && git commit -m "modules"

# Update Dependencies
update:; forge update

build:; forge build

test :; forge test

snapshot :; forge snapshot

format :; forge fmt

anvil :; anvil -m 'test test test test test test test test test test test junk' --steps-tracing --block-time 1

deploy:
	@forge script script/DeployTxEnforcerV1.s.sol:DeployTxEnforcerV1 $(NETWORK_ARGS)

NETWORK_ARGS := --rpc-url http://localhost:8545 --account $(LOCAL_ACCOUNT) --broadcast

ifeq ($(findstring --network sepolia,$(ARGS)),--network sepolia)
    NETWORK_ARGS := \
      --rpc-url $(SEPOLIA_RPC_URL) \
      --account $(SEPOLIA_ACCOUNT) \
      --broadcast \
      --verify \
      --etherscan-api-key $(ETHERSCAN_API_KEY) \
      -vvvv
endif

deploy-sepolia:
	@forge script script/DeployTxEnforcerV1.s.sol:DeployTxEnforcerV1 $(NETWORK_ARGS)

