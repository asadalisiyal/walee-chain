#!/usr/bin/env sh

# Input parameters
ARCH=$(uname -m)

# Build wled
echo "Building wled from local branch"
git config --global --add safe.directory /sei-protocol/sei-chain
LEDGER_ENABLED=false
make install
mkdir -p build/generated
echo "DONE" > build/generated/build.complete
