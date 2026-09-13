#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ARTIFACTS_DIR="${ARTIFACTS_DIR:-$ROOT_DIR/artifacts}"
ANYKERNEL_DIR="${ANYKERNEL_DIR:-$ROOT_DIR/AnyKernel3}"
KERNEL_IMAGE="${KERNEL_IMAGE:-}"
OUTPUT_ZIP="${OUTPUT_ZIP:-$ARTIFACTS_DIR/AnyKernel3-rodin-$(date +%Y%m%d-%H%M%S).zip}"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --anykernel-dir)
      ANYKERNEL_DIR="$2"
      shift 2
      ;;
    --image)
      KERNEL_IMAGE="$2"
      shift 2
      ;;
    --output)
      OUTPUT_ZIP="$2"
      shift 2
      ;;
    *)
      echo "[-] Unknown argument: $1"
      exit 1
      ;;
  esac
done

if [[ ! -d "$ANYKERNEL_DIR" ]]; then
  echo "[-] AnyKernel3 directory not found: $ANYKERNEL_DIR"
  exit 1
fi

if [[ ! -f "$ANYKERNEL_DIR/anykernel.sh" ]]; then
  echo "[-] Missing anykernel.sh in: $ANYKERNEL_DIR"
  exit 1
fi

if [[ -z "$KERNEL_IMAGE" ]]; then
  for candidate in \
    "$ARTIFACTS_DIR/Image.gz-dtb" \
    "$ARTIFACTS_DIR/Image.gz" \
    "$ARTIFACTS_DIR/Image" \
    "$ROOT_DIR/out/arch/arm64/boot/Image.gz-dtb" \
    "$ROOT_DIR/out/arch/arm64/boot/Image.gz" \
    "$ROOT_DIR/out/arch/arm64/boot/Image"; do
    if [[ -f "$candidate" ]]; then
      KERNEL_IMAGE="$candidate"
      break
    fi
  done
fi

if [[ -z "$KERNEL_IMAGE" || ! -f "$KERNEL_IMAGE" ]]; then
  echo "[-] Kernel image not found. Build first or pass --image <path>."
  exit 1
fi

mkdir -p "$ARTIFACTS_DIR"
cp -v "$KERNEL_IMAGE" "$ANYKERNEL_DIR/$(basename "$KERNEL_IMAGE")"

pushd "$ANYKERNEL_DIR" >/dev/null
zip -r9 "$OUTPUT_ZIP" . -x ".git/*" ".github/*" "README.md"
popd >/dev/null

echo "[+] AnyKernel3 package created: $OUTPUT_ZIP"
