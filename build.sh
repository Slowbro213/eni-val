#!/usr/bin/env bash
set -euo pipefail

CONFIG_ENV="config.env"
TEMPLATE="html/index.html"
OUT_DIR="public"

mkdir -p "$OUT_DIR"

set -a
source "$CONFIG_ENV"
set +a

VARS=$(
  grep -oE '\$\{[A-Za-z_][A-Za-z0-9_]*\}' "$TEMPLATE" \
  | sort -u \
  | tr '\n' ' '
)

envsubst "$VARS" < "$TEMPLATE" > "$OUT_DIR/index.html"

