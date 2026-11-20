FROM python:3.12-trixie

WORKDIR /app

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
COPY pyproject.toml pyproject.toml
COPY uv.lock uv.lock
#COPY api ./api
COPY src ./src
#COPY models ./models
COPY README.md README.md
COPY app.py app.py

RUN uv sync

ENV UV_NO_DEV=1 \
    UV_FROZEN=1

CMD uv run streamlit run app.py --server.port 8501
