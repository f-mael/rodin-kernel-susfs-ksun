# rodin-kernel-susfs-ksun

Kernel build environment for **Poco X7 Pro (rodin)** with **SUSFS** and **KSU Next** integration workflow.

> ⚠️ **Important**
> - This repository provides a **clean and reproducible build scaffold**.
> - You must use the **correct kernel source for rodin**, and ensure compatibility for SUSFS/KSU Next patches with your target kernel version.
> - Use this only on devices you own and for legitimate development/research.

## Contents

- `docs/` – setup and integration guides
- `scripts/` – automation scripts
- `patches/` – place for SUSFS/KSU related patches
- `configs/` – optional kernel config fragments
- `out/` – build output directory (ignored)

## Quick start

1. Open `docs/setup.md`
2. Run environment setup script:
   ```bash
   ./scripts/setup_env.sh
   ```
3. Place your kernel source in `kernel_source/` (or clone directly there)
4. Follow `docs/integration-susfs-ksun.md`
5. Build with:
   ```bash
   ./scripts/build_kernel.sh
   ```

## Expected host (recommended)

- Ubuntu 22.04/24.04
- `clang`, `lld`, `llvm`, `bc`, `bison`, `flex`, `libssl-dev`, `libelf-dev`, `ccache`

## Device target

- Codename: **rodin**
- Device: **Poco X7 Pro**

## Legal / responsibility

You are responsible for compliance with licenses, terms, and local regulations.
