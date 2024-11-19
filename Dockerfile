FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim
WORKDIR /app
ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy

# GOAL: install only the dependencies that stem from "foo"
#       ie. this should NOT install packages/baz or dpath

RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    # have to also mount packages directory to avoid "package foo not found"
    # (this is because we had to remove --frozen)
    --mount=type=bind,source=packages,target=packages \
    # unfortunately, cannot use --frozen with --package
    uv sync --no-install-workspace --no-dev --package foo
