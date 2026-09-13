#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_DIR="$ROOT_DIR/kernel_source"

if [[ ! -d "$SRC_DIR/.git" ]]; then
  echo "[-] $SRC_DIR is not a git repository"
  exit 1
fi

pushd "$SRC_DIR" >/dev/null

echo "[+] Applying SUSFS patches..."
for p in "$ROOT_DIR"/patches/susfs/*.patch; do
  [[ -f "$p" ]] || continue
  echo "  - $p"
  git am "$p"
done

echo "[+] Applying KSU Next patches..."
for p in "$ROOT_DIR"/patches/ksun/*.patch; do
  [[ -f "$p" ]] || continue
  echo "  - $p"
  git am "$p"
done

echo "[+] Patch application complete"
popd >/dev/null
