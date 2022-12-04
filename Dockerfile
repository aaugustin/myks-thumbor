ARG PYTHON=3.10

FROM python:${PYTHON}-slim AS builder

WORKDIR /app

RUN  apt-get update && apt-get install -y \
    build-essential \
    git \
    libcurl4-openssl-dev \
    libssl-dev

COPY requirements.txt ./
ENV PATH "/app/venv/bin:$PATH"
RUN python -m venv venv && \
    pip install --no-cache-dir -r requirements.txt

FROM python:${PYTHON}-slim AS runner

WORKDIR /app

ENV PATH "/app/venv/bin:$PATH"
ENV PYTHONUNBUFFERED 1

COPY --from=builder /app /app
COPY thumbor.conf ./

CMD ["thumbor", "--port", "8080", "--processes", "4"]

EXPOSE 8080
