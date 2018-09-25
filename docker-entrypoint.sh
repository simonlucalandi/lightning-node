#!/bin/bash
set -e

if [[ "$1" == "bitcoin-cli" || "$1" == "bitcoin-tx" || "$1" == "bitcoind" || "$1" == "test_bitcoin" ]]; then
    mkdir -p "$BITCOIN_DATA"

    if [[ ! -s "$BITCOIN_DATA/bitcoin.conf" ]]; then
	cat <<-EOF > "$BITCOIN_DATA/bitcoin.conf"
# Bitcoind options
server=1
txindex=0
disablewallet=1
prune=550

# Connection settings

onlynet=ipv4
zmqpubrawblock=tcp://0.0.0.0:29000
zmqpubrawtx=tcp://0.0.0.0:29001

printtoconsole=1
rpcallowip=::/0
rpcpassword=${BITCOIN_RPC_PASSWORD:-password}
rpcuser=${BITCOIN_RPC_USER:-bitcoin}

# optimizations
dbcache=100
maxorphantx=10
maxmempool=50
maxconnections=40
maxuploadtarget=5000

	EOF
        chown bitcoin:bitcoin "$BITCOIN_DATA/bitcoin.conf"
    fi

    # ensure correct ownership and linking of data directory
    # we do not update group ownership here, in case users want to mount
    # a host directory and still retain access to it
    chown -R bitcoin "$BITCOIN_DATA"
    ln -sfn "$BITCOIN_DATA" /home/bitcoin/.bitcoin
    chown -h bitcoin:bitcoin /home/bitcoin/.bitcoin

    exec gosu bitcoin "$@"
fi

exec "$@"
