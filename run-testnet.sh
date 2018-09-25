docker run --rm \
    --name=bitcoind \
    --net ln \
    -v bitcoin-data:/data \
    bitcoind bitcoind -testnet -prune=550 -bind=0.0.0.0
