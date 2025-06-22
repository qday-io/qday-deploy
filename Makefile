DOCKERCOMPOSE := docker compose -f docker-compose.yml 
DOCKERCOMPOSE_RPC1 := docker compose -f docker-compose-rpc1.yml
DOCKERCOMPOSE_RPC2 := docker compose -f docker-compose-rpc2.yml
DOCKERCOMPOSEAPPSEQ := zkevm-sequencer
DOCKERCOMPOSEAPPSEQSENDER := zkevm-sequence-sender
DOCKERCOMPOSEAPPL2GASP := zkevm-l2gaspricer
DOCKERCOMPOSEAPPAGG := zkevm-aggregator
DOCKERCOMPOSEAPPRPC := zkevm-json-rpc
DOCKERCOMPOSEAPPSYNC := zkevm-sync
DOCKERCOMPOSEAPPETHTXMANAGER := zkevm-eth-tx-manager
DOCKERCOMPOSESTATEDB := zkevm-state-db
DOCKERCOMPOSEPOOLDB := zkevm-pool-db
DOCKERCOMPOSEEVENTDB := zkevm-event-db
DOCKERCOMPOSENETWORK := zkevm-mock-l1-network
DOCKERCOMPOSEEXPLORERL1 := zkevm-explorer-l1
DOCKERCOMPOSEEXPLORERL1DB := zkevm-explorer-l1-db
DOCKERCOMPOSEEXPLORERL2 := zkevm-explorer-l2
DOCKERCOMPOSEEXPLORERL2DB := zkevm-explorer-l2-db
DOCKERCOMPOSEEXPLORERRPC := zkevm-explorer-json-rpc
DOCKERCOMPOSEZKPROVER := zkevm-prover
DOCKERCOMPOSENODEAPPROVE := zkevm-approve

# RPC1 services
DOCKERCOMPOSEAPPRPC1 := zkevm-json-rpc-1
DOCKERCOMPOSEZKPROVER1 := zkevm-prover-1
DOCKERCOMPOSESYNC1 := zkevm-sync-1
DOCKERCOMPOSESTATEDB1 := zkevm-state-db
DOCKERCOMPOSEPOOLDB1 := zkevm-pool-db
DOCKERCOMPOSEEVENTDB1 := zkevm-event-db

# RPC2 services
DOCKERCOMPOSEAPPRPC2 := zkevm-json-rpc-2
DOCKERCOMPOSEZKPROVER2 := zkevm-prover-2
DOCKERCOMPOSESYNC2 := zkevm-sync-2
DOCKERCOMPOSESTATEDB2 := zkevm-state-db-2
DOCKERCOMPOSEPOOLDB2 := zkevm-pool-db-2
DOCKERCOMPOSEEVENTDB2 := zkevm-event-db-2

RUNSTATEDB := $(DOCKERCOMPOSE) up -d $(DOCKERCOMPOSESTATEDB)
RUNPOOLDB := $(DOCKERCOMPOSE) up -d $(DOCKERCOMPOSEPOOLDB)
RUNEVENTDB := $(DOCKERCOMPOSE) up -d $(DOCKERCOMPOSEEVENTDB)
RUNSEQUENCER := $(DOCKERCOMPOSE) up -d $(DOCKERCOMPOSEAPPSEQ)
RUNSEQUENCESENDER := $(DOCKERCOMPOSE) up -d $(DOCKERCOMPOSEAPPSEQSENDER)
RUNL2GASPRICER := $(DOCKERCOMPOSE) up -d $(DOCKERCOMPOSEAPPL2GASP)
RUNAGGREGATOR := $(DOCKERCOMPOSE) up -d $(DOCKERCOMPOSEAPPAGG)
RUNJSONRPC := $(DOCKERCOMPOSE) up -d $(DOCKERCOMPOSEAPPRPC)
RUNSYNC := $(DOCKERCOMPOSE) up -d $(DOCKERCOMPOSEAPPSYNC)
RUNETHTXMANAGER := $(DOCKERCOMPOSE) up -d $(DOCKERCOMPOSEAPPETHTXMANAGER)
RUNL1NETWORK := $(DOCKERCOMPOSE) up -d $(DOCKERCOMPOSENETWORK)
RUNEXPLORERL1 := $(DOCKERCOMPOSE) up -d $(DOCKERCOMPOSEEXPLORERL1)
RUNEXPLORERL1DB := $(DOCKERCOMPOSE) up -d $(DOCKERCOMPOSEEXPLORERL1DB)
RUNEXPLORERL2 := $(DOCKERCOMPOSE) up -d $(DOCKERCOMPOSEEXPLORERL2)
RUNEXPLORERL2DB := $(DOCKERCOMPOSE) up -d $(DOCKERCOMPOSEEXPLORERL2DB)
RUNEXPLORERJSONRPC := $(DOCKERCOMPOSE) up -d $(DOCKERCOMPOSEEXPLORERRPC)
RUNZKPROVER := $(DOCKERCOMPOSE) up -d $(DOCKERCOMPOSEZKPROVER)
RUNAPPROVE := $(DOCKERCOMPOSE) up -d $(DOCKERCOMPOSENODEAPPROVE)

# RPC1 commands
RUNSTATEDB1 := $(DOCKERCOMPOSE_RPC1) up -d $(DOCKERCOMPOSESTATEDB1)
RUNPOOLDB1 := $(DOCKERCOMPOSE_RPC1) up -d $(DOCKERCOMPOSEPOOLDB1)
RUNEVENTDB1 := $(DOCKERCOMPOSE_RPC1) up -d $(DOCKERCOMPOSEEVENTDB1)
RUNJSONRPC1 := $(DOCKERCOMPOSE_RPC1) up -d $(DOCKERCOMPOSEAPPRPC1)
RUNZKPROVER1 := $(DOCKERCOMPOSE_RPC1) up -d $(DOCKERCOMPOSEZKPROVER1)
RUNSYNC1 := $(DOCKERCOMPOSE_RPC1) up -d $(DOCKERCOMPOSESYNC1)

# RPC2 commands
RUNSTATEDB2 := $(DOCKERCOMPOSE_RPC2) up -d $(DOCKERCOMPOSESTATEDB2)
RUNPOOLDB2 := $(DOCKERCOMPOSE_RPC2) up -d $(DOCKERCOMPOSEPOOLDB2)
RUNEVENTDB2 := $(DOCKERCOMPOSE_RPC2) up -d $(DOCKERCOMPOSEEVENTDB2)
RUNJSONRPC2 := $(DOCKERCOMPOSE_RPC2) up -d $(DOCKERCOMPOSEAPPRPC2)
RUNZKPROVER2 := $(DOCKERCOMPOSE_RPC2) up -d $(DOCKERCOMPOSEZKPROVER2)
RUNSYNC2 := $(DOCKERCOMPOSE_RPC2) up -d $(DOCKERCOMPOSESYNC2)

RUN := $(DOCKERCOMPOSE) up -d

STOPSTATEDB := $(DOCKERCOMPOSE) stop $(DOCKERCOMPOSESTATEDB) && $(DOCKERCOMPOSE) rm -f $(DOCKERCOMPOSESTATEDB)
STOPPOOLDB := $(DOCKERCOMPOSE) stop $(DOCKERCOMPOSEPOOLDB) && $(DOCKERCOMPOSE) rm -f $(DOCKERCOMPOSEPOOLDB)
STOPEVENTDB := $(DOCKERCOMPOSE) stop $(DOCKERCOMPOSEEVENTDB) && $(DOCKERCOMPOSE) rm -f $(DOCKERCOMPOSEEVENTDB)
STOPSEQUENCER := $(DOCKERCOMPOSE) stop $(DOCKERCOMPOSEAPPSEQ) && $(DOCKERCOMPOSE) rm -f $(DOCKERCOMPOSEAPPSEQ)
STOPSEQUENCESENDER := $(DOCKERCOMPOSE) stop $(DOCKERCOMPOSEAPPSEQSENDER) && $(DOCKERCOMPOSE) rm -f $(DOCKERCOMPOSEAPPSEQSENDER)
STOPL2GASPRICER := $(DOCKERCOMPOSE) stop $(DOCKERCOMPOSEAPPL2GASP) && $(DOCKERCOMPOSE) rm -f $(DOCKERCOMPOSEAPPL2GASP)
STOPAGGREGATOR := $(DOCKERCOMPOSE) stop $(DOCKERCOMPOSEAPPAGG) && $(DOCKERCOMPOSE) rm -f $(DOCKERCOMPOSEAPPAGG)
STOPJSONRPC := $(DOCKERCOMPOSE) stop $(DOCKERCOMPOSEAPPRPC) && $(DOCKERCOMPOSE) rm -f $(DOCKERCOMPOSEAPPRPC)
STOPSYNC := $(DOCKERCOMPOSE) stop $(DOCKERCOMPOSEAPPSYNC) && $(DOCKERCOMPOSE) rm -f $(DOCKERCOMPOSEAPPSYNC)
STOPETHTXMANAGER := $(DOCKERCOMPOSE) stop $(DOCKERCOMPOSEAPPETHTXMANAGER) && $(DOCKERCOMPOSE) rm -f $(DOCKERCOMPOSEAPPETHTXMANAGER)
STOPNETWORK := $(DOCKERCOMPOSE) stop $(DOCKERCOMPOSENETWORK) && $(DOCKERCOMPOSE) rm -f $(DOCKERCOMPOSENETWORK)
STOPEXPLORERL1 := $(DOCKERCOMPOSE) stop $(DOCKERCOMPOSEEXPLORERL1) && $(DOCKERCOMPOSE) rm -f $(DOCKERCOMPOSEEXPLORERL1)
STOPEXPLORERL1DB := $(DOCKERCOMPOSE) stop $(DOCKERCOMPOSEEXPLORERL1DB) && $(DOCKERCOMPOSE) rm -f $(DOCKERCOMPOSEEXPLORERL1DB)
STOPEXPLORERL2 := $(DOCKERCOMPOSE) stop $(DOCKERCOMPOSEEXPLORERL2) && $(DOCKERCOMPOSE) rm -f $(DOCKERCOMPOSEEXPLORERL2)
STOPEXPLORERL2DB := $(DOCKERCOMPOSE) stop $(DOCKERCOMPOSEEXPLORERL2DB) && $(DOCKERCOMPOSE) rm -f $(DOCKERCOMPOSEEXPLORERL2DB)
STOPEXPLORERJSONRPC := $(DOCKERCOMPOSE) stop $(DOCKERCOMPOSEEXPLORERRPC) && $(DOCKERCOMPOSE) rm -f $(DOCKERCOMPOSEEXPLORERRPC)
STOPZKPROVER := $(DOCKERCOMPOSE) stop $(DOCKERCOMPOSEZKPROVER) && $(DOCKERCOMPOSE) rm -f $(DOCKERCOMPOSEZKPROVER)
STOPAPPROVE := $(DOCKERCOMPOSE) stop $(DOCKERCOMPOSENODEAPPROVE) && $(DOCKERCOMPOSE) rm -f $(DOCKERCOMPOSENODEAPPROVE)

# RPC1 stop commands
STOPSTATEDB1 := $(DOCKERCOMPOSE_RPC1) stop $(DOCKERCOMPOSESTATEDB1) && $(DOCKERCOMPOSE_RPC1) rm -f $(DOCKERCOMPOSESTATEDB1)
STOPPOOLDB1 := $(DOCKERCOMPOSE_RPC1) stop $(DOCKERCOMPOSEPOOLDB1) && $(DOCKERCOMPOSE_RPC1) rm -f $(DOCKERCOMPOSEPOOLDB1)
STOPEVENTDB1 := $(DOCKERCOMPOSE_RPC1) stop $(DOCKERCOMPOSEEVENTDB1) && $(DOCKERCOMPOSE_RPC1) rm -f $(DOCKERCOMPOSEEVENTDB1)
STOPJSONRPC1 := $(DOCKERCOMPOSE_RPC1) stop $(DOCKERCOMPOSEAPPRPC1) && $(DOCKERCOMPOSE_RPC1) rm -f $(DOCKERCOMPOSEAPPRPC1)
STOPZKPROVER1 := $(DOCKERCOMPOSE_RPC1) stop $(DOCKERCOMPOSEZKPROVER1) && $(DOCKERCOMPOSE_RPC1) rm -f $(DOCKERCOMPOSEZKPROVER1)
STOPSYNC1 := $(DOCKERCOMPOSE_RPC1) stop $(DOCKERCOMPOSESYNC1) && $(DOCKERCOMPOSE_RPC1) rm -f $(DOCKERCOMPOSESYNC1)

# RPC2 stop commands
STOPSTATEDB2 := $(DOCKERCOMPOSE_RPC2) stop $(DOCKERCOMPOSESTATEDB2) && $(DOCKERCOMPOSE_RPC2) rm -f $(DOCKERCOMPOSESTATEDB2)
STOPPOOLDB2 := $(DOCKERCOMPOSE_RPC2) stop $(DOCKERCOMPOSEPOOLDB2) && $(DOCKERCOMPOSE_RPC2) rm -f $(DOCKERCOMPOSEPOOLDB2)
STOPEVENTDB2 := $(DOCKERCOMPOSE_RPC2) stop $(DOCKERCOMPOSEEVENTDB2) && $(DOCKERCOMPOSE_RPC2) rm -f $(DOCKERCOMPOSEEVENTDB2)
STOPJSONRPC2 := $(DOCKERCOMPOSE_RPC2) stop $(DOCKERCOMPOSEAPPRPC2) && $(DOCKERCOMPOSE_RPC2) rm -f $(DOCKERCOMPOSEAPPRPC2)
STOPZKPROVER2 := $(DOCKERCOMPOSE_RPC2) stop $(DOCKERCOMPOSEZKPROVER2) && $(DOCKERCOMPOSE_RPC2) rm -f $(DOCKERCOMPOSEZKPROVER2)
STOPSYNC2 := $(DOCKERCOMPOSE_RPC2) stop $(DOCKERCOMPOSESYNC2) && $(DOCKERCOMPOSE_RPC2) rm -f $(DOCKERCOMPOSESYNC2)

STOP := $(DOCKERCOMPOSE) down --remove-orphans
STOP_RPC1 := $(DOCKERCOMPOSE_RPC1) down --remove-orphans
STOP_RPC2 := $(DOCKERCOMPOSE_RPC2) down --remove-orphans

.PHONY: run-db
run-db: ## Runs the node database
	$(RUNSTATEDB)
	$(RUNPOOLDB)
	$(RUNEVENTDB)

.PHONY: stop-db
stop-db: ## Stops the node database
	$(STOPEVENTDB)
	$(STOPPOOLDB)
	$(STOPSTATEDB)

.PHONY: run-node
run-node: ## Runs the node
	$(RUNSYNC)
	sleep 4
	$(RUNETHTXMANAGER)
	$(RUNSEQUENCER)
	$(RUNSEQUENCESENDER)
	$(RUNL2GASPRICER)
	$(RUNAGGREGATOR)
	$(RUNJSONRPC)

.PHONY: stop-node
stop-node: ## Stops the node
	$(STOPSEQUENCER)
	$(STOPSEQUENCESENDER)
	$(STOPJSONRPC)
	$(STOPL2GASPRICER)
	$(STOPAGGREGATOR)
	$(STOPSYNC)
	$(STOPETHTXMANAGER)

.PHONY: run-network
run-network: ## Runs the l1 network
	$(RUNL1NETWORK)

.PHONY: stop-network
stop-network: ## Stops the l1 network
	$(STOPNETWORK)

.PHONY: run-zkprover
run-zkprover: ## Runs zkprover
	$(RUNZKPROVER)

.PHONY: stop-zkprover
stop-zkprover: ## Stops zkprover
	$(STOPZKPROVER)

.PHONY: run-l1-explorer
run-l1-explorer: ## Runs L1 blockscan explorer 
	$(RUNEXPLORERL1DB)
	$(RUNEXPLORERL1)

.PHONY: run-l2-explorer
run-l2-explorer: ## Runs L2 blockscan explorer
	$(RUNEXPLORERL2DB)
	$(RUNEXPLORERJSONRPC)
	$(RUNEXPLORERL2)

.PHONY: run-l2-explorer-json-rpc
run-l2-explorer-json-rpc: ## Runs L2 explorer json rpc
	$(RUNEXPLORERJSONRPC)

.PHONY: stop-l2-explorer-json-rpc
stop-l2-explorer-json-rpc: ## Stops L2 explorer json rpc
	$(STOPEXPLORERJSONRPC)

.PHONY: run-explorer
run-explorer: run-l1-explorer run-l2-explorer ## Runs both L1 and L2 explorers

.PHONY: stop-explorer
stop-explorer: ## Stops the explorer
	$(STOPEXPLORERL2)
	$(STOPEXPLORERL1)
	$(STOPEXPLORERJSONRPC)
	$(STOPEXPLORERL2DB)
	$(STOPEXPLORERL1DB)

.PHONY: run-explorer-db
run-explorer-db: ## Runs the explorer database
	$(RUNEXPLORERL1DB)
	$(RUNEXPLORERL2DB)

.PHONY: stop-explorer-db
stop-explorer-db: ## Stops the explorer database
	$(STOPEXPLORERL2DB)
	$(STOPEXPLORERL1DB)

.PHONY: run-seq
run-seq: ## runs the sequencer
	$(RUNSEQUENCER)

.PHONY: stop-seq
stop-seq: ## stops the sequencer
	$(STOPSEQUENCER)

.PHONY: run-seqsender
run-seqsender: ## runs the sequencer sender
	$(RUNSEQUENCESENDER)

.PHONY: stop-seqsender
stop-seqsender: ## stops the sequencer sender
	$(STOPSEQUENCESENDER)

.PHONY: run-sync
run-sync: ## runs the synchronizer
	$(RUNSYNC)

.PHONY: stop-sync
stop-sync: ## stops the synchronizer
	$(STOPSYNC)

.PHONY: run-json-rpc
run-json-rpc: ## runs the JSON-RPC
	$(RUNJSONRPC)

.PHONY: stop-json-rpc
stop-json-rpc: ## stops the JSON-RPC
	$(STOPJSONRPC)

.PHONY: run-l2gaspricer
run-l2gaspricer: ## runs the L2 Gas Price component
	$(RUNL2GASPRICER)

.PHONY: stop-l2gaspricer
stop-l2gaspricer: ## stops the L2 Gas Price component
	$(STOPL2GASPRICER)

.PHONY: run-eth-tx-manager
run-eth-tx-manager: ## Runs the eth tx manager service
	$(RUNETHTXMANAGER)

.PHONY: stop-eth-tx-manager
stop-eth-tx-manager: ## Stops the eth tx manager service
	$(STOPETHTXMANAGER)

.PHONY: run
run: ## Runs a full node
	$(RUNL1NETWORK)
	$(RUNSTATEDB)
	$(RUNPOOLDB)
	$(RUNEVENTDB)
	sleep 10
	$(RUNZKPROVER)
	$(RUNAPPROVE)
	sleep 3
	$(RUNSYNC)
	sleep 4
	$(RUNETHTXMANAGER)
	$(RUNSEQUENCER)
	$(RUNSEQUENCESENDER)
	$(RUNL2GASPRICER)
	$(RUNAGGREGATOR)
	$(RUNJSONRPC)

.PHONY: stop
stop: ## Stops all services
	$(STOP)

.PHONY: restart
restart: stop run ## Executes `make stop` and `make run` commands

.PHONY: show-logs
show-logs:  ## Show logs for running docker 
	$(DOCKERCOMPOSE) logs

.PHONY: clean
clean: ## Cleans up all containers and volumes
	$(STOP)
	sudo rm -fr data/db data/keystore/test.keystore ./data/datastreamer

.PHONY: da-node
da-node: ## Runs only the l1 network
	$(RUNL1NETWORK)

.PHONY: stop-da-node
stop-da-node: ## Stops only the l1 network
	$(STOPNETWORK)

.PHONY: restart-da-node
restart-da-node: stop-da-node da-node ## Restarts only the l1 network


.PHONY: main-node
main-node: ## Runs a full node
	$(RUNSTATEDB)
	$(RUNPOOLDB)
	$(RUNEVENTDB)
	sleep 10
	$(RUNZKPROVER)
	$(RUNAPPROVE)
	sleep 3
	$(RUNSYNC)
	sleep 4
	$(RUNETHTXMANAGER)
	$(RUNSEQUENCER)
	$(RUNSEQUENCESENDER)
	$(RUNL2GASPRICER)
	$(RUNAGGREGATOR)
	$(RUNJSONRPC)

.PHONY: stop-main-node
stop-main-node: ## Stops a full node
	$(STOPSEQUENCER)
	$(STOPSEQUENCESENDER)
	$(STOPJSONRPC)
	$(STOPL2GASPRICER)
	$(STOPAGGREGATOR)
	$(STOPSYNC)
	$(STOPETHTXMANAGER)
	$(STOPAPPROVE)
	$(STOPZKPROVER)
	$(STOPEVENTDB)
	$(STOPPOOLDB)
	$(STOPSTATEDB)

.PHONY: rpc-node
rpc-node: ## Runs only the rpc node (prover, pool-db, state-db, sync, json-rpc)
	$(RUNZKPROVER)
	$(RUNPOOLDB)
	$(RUNSTATEDB)
	$(RUNSYNC)
	$(RUNJSONRPC)

.PHONY: stop-rpc-node
stop-rpc-node: ## Stops only the rpc node (prover, pool-db, state-db, sync, json-rpc)
	$(STOPZKPROVER)
	$(STOPPOOLDB)
	$(STOPSTATEDB)
	$(STOPSYNC)
	$(STOPJSONRPC)

.PHONY: restart-rpc-node
restart-rpc-node: stop-rpc-node rpc-node ## Restarts only the rpc node

.PHONY: rpc-node-1
rpc-node-1: ## Runs RPC node 1 (prover, pool-db, state-db, event-db, sync, json-rpc)
	$(RUNSTATEDB1)
	$(RUNPOOLDB1)
	$(RUNEVENTDB1)
	sleep 10
	$(RUNZKPROVER1)
	sleep 3
	$(RUNSYNC1)
	sleep 4
	$(RUNJSONRPC1)

.PHONY: stop-rpc-node-1
stop-rpc-node-1: ## Stops RPC node 1
	$(STOPJSONRPC1)
	$(STOPSYNC1)
	$(STOPZKPROVER1)
	$(STOPEVENTDB1)
	$(STOPPOOLDB1)
	$(STOPSTATEDB1)

.PHONY: restart-rpc-node-1
restart-rpc-node-1: stop-rpc-node-1 rpc-node-1 ## Restarts RPC node 1

.PHONY: rpc-node-2
rpc-node-2: ## Runs RPC node 2 (prover, pool-db, state-db, event-db, sync, json-rpc)
	$(RUNSTATEDB2)
	$(RUNPOOLDB2)
	$(RUNEVENTDB2)
	sleep 10
	$(RUNZKPROVER2)
	sleep 3
	$(RUNSYNC2)
	sleep 4
	$(RUNJSONRPC2)

.PHONY: stop-rpc-node-2
stop-rpc-node-2: ## Stops RPC node 2
	$(STOPJSONRPC2)
	$(STOPSYNC2)
	$(STOPZKPROVER2)
	$(STOPEVENTDB2)
	$(STOPPOOLDB2)
	$(STOPSTATEDB2)

.PHONY: restart-rpc-node-2
restart-rpc-node-2: stop-rpc-node-2 rpc-node-2 ## Restarts RPC node 2

.PHONY: rpc-nodes
rpc-nodes: rpc-node-1 rpc-node-2 ## Runs both RPC nodes

.PHONY: stop-rpc-nodes
stop-rpc-nodes: stop-rpc-node-1 stop-rpc-node-2 ## Stops both RPC nodes

.PHONY: restart-rpc-nodes
restart-rpc-nodes: stop-rpc-nodes rpc-nodes ## Restarts both RPC nodes

.PHONY: test-rpc-nodes
test-rpc-nodes: ## Test both RPC nodes connectivity
	./test-rpc-nodes.sh

.PHONY: fix-db-migrations
fix-db-migrations: ## Fix database migrations for zkEVM nodes
	./fix-db-migrations.sh

## Help display.
## Pulls comments from beside commands and prints a nicely formatted
## display with the commands and their usage information.
.DEFAULT_GOAL := help

.PHONY: help
help: ## Prints this help
		@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
