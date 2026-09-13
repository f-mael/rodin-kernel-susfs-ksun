#!/usr/bin/env bash
set -euo pipefail

# ---- user-tunable defaults ----
DEFCONFIG="rodin_defconfig"
JOBS="$(nproc --all)"

# ---- paths ----
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC_DIR="$ROOT_DIR/kernel_source"
OUT_DIR="$ROOT_DIR/out"
ARTIFACTS_DIR="$ROOT_DIR/artifacts"
LOG_FILE="$ARTIFACTS_DIR/build-$(date +%Y%m%d-%H%M%S).log"

# ---- env ----
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER="${KBUILD_BUILD_USER:-f-mael}"
export KBUILD_BUILD_HOST="${KBUILD_BUILD_HOST:-local}"
export CC=clang
export LLVM=1
export LLVM_IAS=1

mkdir -p "$OUT_DIR" "$ARTIFACTS_DIR"

if [[ ! -d "$SRC_DIR" ]]; then
  echo "[-] Missing kernel source at: $SRC_DIR"
  exit 1
fi

pushd "$SRC_DIR" >/dev/null

echo "[+] Cleaning output directory: $OUT_DIR"
make O="$OUT_DIR" mrproper

echo "[+] Generating config: $DEFCONFIG"
make O="$OUT_DIR" "$DEFCONFIG"

echo "[+] Building kernel with $JOBS jobs"
set -o pipefail
make O="$OUT_DIR" -j"$JOBS" 2>&1 | tee "$LOG_FILE"

# Try common output locations
IMAGE_CANDIDATES=(
  "$OUT_DIR/arch/arm64/boot/Image"
  "$OUT_DIR/arch/arm64/boot/Image.gz"
  "$OUT_DIR/arch/arm64/boot/Image.gz-dtb"
)

FOUND=0
for img in "${IMAGE_CANDIDATES[@]}"; do
  if [[ -f "$img" ]]; then
    cp -v "$img" "$ARTIFACTS_DIR/"
    FOUND=1
  fi
done

if [[ "$FOUND" -eq 0 ]]; then
  echo "[!] Build completed, but no known kernel image found. Check $LOG_FILE"
else
  echo "[+] Artifacts copied to: $ARTIFACTS_DIR"
fi

popd >/dev/null
