# Define a helper function to read .env variables
ifneq (,$(wildcard ./.env))
    include .env
    export $(shell sed 's/=.*//' .env)
endif

# Define the target
deploy-protocol:
	@forge script ./deploy/DeployProtocol.s.sol --rpc-url $(RPC_URL) --private-key $(DEPLOYER_PRIVATE_KEY) --broadcast --legacy
