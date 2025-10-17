#!/usr/bin/env bash

set -e

pip3 install --root-user-action=ignore maturin~=1.9 patchelf cffi ziglang sccache>=0.4.0

curl -o rustup.sh --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs
sh rustup.sh -y
source $HOME/.cargo/env
rustup update
rustc -V

cargo install cargo-chef --locked

ARCH=$(uname -m)

PB_REL="https://github.com/protocolbuffers/protobuf/releases"

cd /usr

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
chmod 755 /usr/bin/protoc
