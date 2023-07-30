#!/bin/sh
set -exu

GETH_DATA_DIR=/data
GETH_CHAINDATA_DIR="$GETH_DATA_DIR/chaindata"
GENESIS_FILE_PATH="/genesis.json"

# address
if [ ! -d "$GETH_CHAINDATA_DIR" ]; then
  echo "Initialize geth..."
  geth --sepolia dumpgenesis > $GENESIS_FILE_PATH

  echo "[Geth] Initializing genesis"
  geth init \
    --datadir="$GETH_DATA_DIR" \
    "$GENESIS_FILE_PATH"
    
else
  echo "$GETH_CHAINDATA_DIR exists."
fi

exec geth \
  --sepolia \
  --datadir="$GETH_DATA_DIR" \
  --verbosity="3" \
  --http \
  --http.corsdomain="*" \
  --http.vhosts="*" \
  --http.addr=0.0.0.0 \
  --http.port="8545" \
  --http.api="admin,web3,debug,eth,txpool,net,engine" \
  --ws \
  --ws.addr=0.0.0.0 \
  --ws.port="8546" \
  --ws.origins="*" \
  --ws.api="admin,debug,eth,txpool,net,engine" \
  --authrpc.addr="0.0.0.0" \
  --authrpc.port="8551" \
  --authrpc.vhosts="*" \
  --authrpc.jwtsecret=/config/jwt-secret.txt \
  --allow-insecure-unlock \
  --syncmode=snap \
  --gcmode=archive \
  --metrics.expensive \
  --metrics.addr="0.0.0.0" \
  --metrics.port="6060" \
  "$@"