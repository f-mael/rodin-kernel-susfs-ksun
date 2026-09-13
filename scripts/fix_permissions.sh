#!/usr/bin/env bash
set -euo pipefail

for f in scripts/*.sh; do
  chmod +x "$f"
done

echo "[+] Script permissions updated"
