#!/bin/bash

PWD_CMD="pwd"
# get native Windows paths on Mingw
uname | grep -qi mingw && PWD_CMD="pwd -W"

cd $(dirname $0)

SIM_ROOT="$($PWD_CMD)"

# Set a default value for the env vars usually supplied by a Makefile
cd $(git rev-parse --show-toplevel)
: ${GIT_ROOT:="$($PWD_CMD)"}
cd - &>/dev/null

NUM_VALIDATORS=${VALIDATORS:-64}
NUM_NODES=${NODES:-1}
NUM_MISSING_NODES=${MISSING_NODES:-2}

SIMULATION_DIR="${SIM_ROOT}/data"
VALIDATORS_DIR="${SIM_ROOT}/validators"
SNAPSHOT_FILE="${SIMULATION_DIR}/state_snapshot.ssz"
SNAPSHOT_FILE_JSON="${SIMULATION_DIR}/state_snapshot.json"
NETWORK_BOOTSTRAP_FILE="${SIMULATION_DIR}/bootstrap_nodes.txt"
BEACON_NODE_BIN="${SIMULATION_DIR}/beacon_node"
MASTER_NODE_ADDRESS_FILE="${SIMULATION_DIR}/node-0/beacon_node.address"

# Compilation flags
NIMFLAGS="-d:insecure -d:chronicles_log_level=TRACE --warnings:off --hints:off --opt:speed"
#-d:libp2p_secure=noise
