FROM python:3.12-slim

WORKDIR /app

# Install git which might be needed for some python packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
 && rm -rf /var/lib/apt/lists/*

COPY . /app

# Install the application and its dependencies
RUN pip install --no-cache-dir .

ENTRYPOINT ["strix"]
CMD ["--help"]
