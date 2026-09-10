#!/usr/bin/env bash
# Dart codegen from OpenAPI spec
# Requires: flutter SDK and java (for openapi-generator)
# Usage: bash scripts/codegen-dart.sh [path-to-mobile-app]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
OPENAPI_SPEC="$PROJECT_DIR/openapi/m0.openapi.yaml"

# Accept mobile app path as argument or default to ../upa-mobile
MOBILE_APP="${1:-$PROJECT_DIR/../upa-mobile}"
OUTPUT_DIR="$MOBILE_APP/lib/data/api"

echo "Generating Dart models from OpenAPI spec..."
echo "Spec: $OPENAPI_SPEC"
echo "Output: $OUTPUT_DIR"

mkdir -p "$OUTPUT_DIR"

# Check if openapi-generator is available
if command -v openapi-generator &> /dev/null; then
  openapi-generator generate \
    -i "$OPENAPI_SPEC" \
    -g dart-dio \
    -o "$OUTPUT_DIR" \
    --additional-properties=pubName=upa_api
  echo "Dart models generated"
elif command -v npx &> /dev/null && npx --yes @openapitools/openapi-generator-cli version &> /dev/null; then
  npx @openapitools/openapi-generator-cli generate \
    -i "$OPENAPI_SPEC" \
    -g dart-dio \
    -o "$OUTPUT_DIR" \
    --additional-properties=pubName=upa_api
  echo "Dart models generated via npx"
else
  echo "openapi-generator not found. Install with:"
  echo "  brew install openapi-generator"
  echo "  or: npm install -g @openapitools/openapi-generator-cli"
  exit 1
fi
