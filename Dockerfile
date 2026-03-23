FROM python:3.12-slim

WORKDIR /app

# Install git which might be needed for some python packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
 && rm -rf /var/lib/apt/lists/*

COPY . /app

# Install the application and its dependencies
RUN pip install --no-cache-dir .

# Add the entrypoint script
RUN chmod +x /app/docker-entrypoint-cli.sh

# Env-var driven mode (headless by default):
#   TARGET_URL        - target website URL (required)
#   INSTRUCTIONS      - inline instructions text
#   INSTRUCTION_FILE  - path to a mounted instructions file
#   SCAN_MODE         - quick | standard | deep
#
# Or pass strix CLI args directly:
#   docker run ... ghcr.io/roeiba/strix --target https://example.com --non-interactive

ENTRYPOINT ["/app/docker-entrypoint-cli.sh"]
