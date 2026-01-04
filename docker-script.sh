#!/bin/sh

# more are planned, there's just not docker imgs for them
PLANNED_PLATFORMS=linux/arm64,linux/amd64,linux/i386,linux/ppc64le,linux/riscv64
CURRENT_PLATFORMS=linux/arm64,linux/amd64
docker buildx build --platform=$CURRENT_PLATFORMS -t libasco-multiplatform-test --progress=plain .
