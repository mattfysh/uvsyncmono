FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim
WORKDIR /app
ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    # have to also mount packages directory to avoid "package foo not found"
    --mount=type=bind,source=packages,target=packages \
    uv sync --no-install-project --no-dev --package foo

RUN ls .venv/lib/python3.12/site-packages/
