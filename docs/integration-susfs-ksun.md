# SUSFS + KSU Next integration workflow

> This file intentionally avoids distributing third-party patch payloads.
> You should place compatible patches/scripts in:
> - `patches/susfs/`
> - `patches/ksun/`

## 1) Prepare source tree

```bash
cd kernel_source
```

## 2) Apply patches (example)

```bash
# SUSFS (example)
for p in ../patches/susfs/*.patch; do
  [ -f "$p" ] && git am "$p"
done

# KSU Next (example)
for p in ../patches/ksun/*.patch; do
  [ -f "$p" ] && git am "$p"
done
```

If your patch set is not `git am` compatible, adapt using `patch -p1 < file.patch`.

## 3) Config tuning

- Start from vendor defconfig for rodin.
- Enable required options for your SUSFS/KSU Next version.
- Keep a copy in `configs/` as fragment or full `.config` backup.

## 4) Build

From repository root:

```bash
./scripts/build_kernel.sh
```

## 5) Packaging

Use your preferred AnyKernel3/vendor workflow and place outputs in `artifacts/`.
