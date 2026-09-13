# Troubleshooting

## `No rule to make target`
- Confirm defconfig name in `scripts/build_kernel.sh`.
- Ensure source tree is correct for rodin.

## Clang/LTO issues
- Try matching toolchain version expected by your kernel tree.
- Disable problematic options only for debugging, not for release.

## Patch conflicts
- Rebase patchset to your exact kernel commit.
- Apply SUSFS first or KSU Next first depending on conflict area and maintainer recommendation.

## Bootloop after flash
- Validate dtbo/vendor_boot compatibility.
- Test with known-good baseline kernel, then reintroduce changes incrementally.
