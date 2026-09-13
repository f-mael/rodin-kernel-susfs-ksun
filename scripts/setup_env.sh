#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "[+] Installing host dependencies (Ubuntu/Debian)..."
sudo apt update
sudo apt install -y \
  git curl wget unzip rsync \
  build-essential bc bison flex \
  libssl-dev libelf-dev dwarves \
  ccache python3 python3-pip \
  clang lld llvm

echo "[+] Creating workspace directories..."
mkdir -p "$ROOT_DIR/kernel_source" \
         "$ROOT_DIR/toolchains" \
         "$ROOT_DIR/out" \
         "$ROOT_DIR/artifacts" \
         "$ROOT_DIR/patches/susfs" \
         "$ROOT_DIR/patches/ksun" \
         "$ROOT_DIR/configs"

echo "[+] Done. Next: place/clone kernel source into $ROOT_DIR/kernel_source"
