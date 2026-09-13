# Setup guide

## 1) Host dependencies (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install -y \
  git curl wget unzip rsync \
  build-essential bc bison flex \
  libssl-dev libelf-dev dwarves \
  ccache python3 python3-pip \
  clang lld llvm
```

## 2) Prepare workspace

```bash
mkdir -p kernel_source toolchains out artifacts patches/susfs patches/ksun configs
```

## 3) Obtain kernel source

Place your rodin-compatible kernel source at:

```bash
kernel_source/
```

## 4) Export common env

```bash
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER=f-mael
export KBUILD_BUILD_HOST=github-codespace
```

## 5) Continue with integration

Follow:

- `docs/integration-susfs-ksun.md`
