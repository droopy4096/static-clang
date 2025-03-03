set -eux

DOCKER=${DOCKER:-podman}

${DOCKER} stop bazel-builder || true
${DOCKER} rm bazel-builder || true
${DOCKER} build -t bazel-base-image .
${DOCKER} run --shm-size=4G \
  -v "$PWD:/static-clang:Z" \
  -v "$PWD/.bazelrc:/home/fakeuser/.bazelrc:Z" \
  -v bazel-cache:/home/fakeuser/.cache/bazel \
  --name bazel-builder -it bazel-base-image bash
