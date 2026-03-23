#!/bin/bash
set -e

# If arguments are passed directly, use them as-is
if [ $# -gt 0 ]; then
  exec strix "$@"
fi

# Otherwise, build CLI args from environment variables
ARGS=()

# Target URL (required)
if [ -n "$TARGET_URL" ]; then
  ARGS+=("--target" "$TARGET_URL")
else
  echo "ERROR: TARGET_URL environment variable is required"
  echo "Usage: docker run -e TARGET_URL=https://example.com ..."
  exit 1
fi

# Instructions (inline text)
if [ -n "$INSTRUCTIONS" ]; then
  ARGS+=("--instruction" "$INSTRUCTIONS")
fi

# Instructions file (mount a file into the container)
if [ -n "$INSTRUCTION_FILE" ]; then
  if [ ! -f "$INSTRUCTION_FILE" ]; then
    echo "ERROR: INSTRUCTION_FILE '$INSTRUCTION_FILE' not found"
    exit 1
  fi
  ARGS+=("--instruction-file" "$INSTRUCTION_FILE")
fi

# Scan mode (quick, standard, deep)
if [ -n "$SCAN_MODE" ]; then
  ARGS+=("--scan-mode" "$SCAN_MODE")
fi

# Always run in non-interactive (headless) mode inside Docker
ARGS+=("--non-interactive")

exec strix "${ARGS[@]}"
