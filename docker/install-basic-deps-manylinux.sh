#!/usr/bin/env bash

set -e

curl -o rustup.sh --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs
sh rustup.sh -y
source $HOME/.cargo/env
rustup update
rustc -V

cargo install cargo-chef --locked

ARCH=$(uname -m)

PB_REL="https://github.com/protocolbuffers/protobuf/releases"

# x86_64
if [ "$ARCH" = "x86_64" ]; then
  curl -LO $PB_REL/download/v3.15.8/protoc-3.15.8-linux-x86_64.zip
elif [ "$ARCH" = "aarch64" ]; then
  curl -LO $PB_REL/download/v3.15.8/protoc-3.15.8-linux-aarch_64.zip
else
    echo "Unsupported architecture $ARCH"
    exit 1
fi

unzip *.zip
cp bin/protoc /usr/bin
chmod 755 /usr/bin/protoc
