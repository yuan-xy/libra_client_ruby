#!/bin/sh
cd ..
mkdir testnet
cd testnet
git clone https://github.com/libra/libra.git
cd libra
git checkout origin/testnet

cp ./scripts/cli/consensus_peers.config.toml ../../libra_client_ruby/

rm ../../libra_client_ruby/protos/*.proto
find . -name *.proto | xargs cp -t ../../libra_client_ruby/protos/
cd ../../libra_client_ruby/
rpl "shared/mempool_status" "mempool_status" protos/mempool.proto

../../libra_client_ruby/transaction_scripts/gen_transaction_bytecode.sh
cp *.bytecode ../../libra_client_ruby/transaction_scripts/
#scp xn@an1:~/libra/

cd ../../libra_client_ruby/
./gen_proto.sh