DOCKERCOMPOSE := docker compose -f docker-compose.yml 
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

STOP := $(DOCKERCOMPOSE) down --remove-orphans

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

## Help display.
## Pulls comments from beside commands and prints a nicely formatted
## display with the commands and their usage information.
.DEFAULT_GOAL := help

.PHONY: help
help: ## Prints this help
		@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
