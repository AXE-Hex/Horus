#!/bin/bash

# ---------------------------------------------------------------------------
# 🛡️ HUE Build & Fingerprint Generator
# 🚀 Developed by the GT-AXE Team
# 👤 Signature: AXE
# ---------------------------------------------------------------------------

# Configuration
VERSION="1.0.0"
COMMIT_HASH=$(git rev-parse --short HEAD 2>/dev/null || echo "uncommitted")
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
BUILD_ID="AXE-$COMMIT_HASH-$TIMESTAMP"

# Generate dart-define flags
DART_DEFINES=(
  "--dart-define=APP_VERSION=$VERSION"
  "--dart-define=BUILD_ID=$BUILD_ID"
  "--dart-define=COMMIT_HASH=$COMMIT_HASH"
  "--dart-define=BUILD_TIMESTAMP=$TIMESTAMP"
)

echo "---------------------------------------------------------------------------"
echo "🚀 Building HUE with IP Protection"
echo "👤 Digital Fingerprint: $BUILD_ID"
echo "---------------------------------------------------------------------------"

echo "Command to run:"
echo "flutter build apk ${DART_DEFINES[*]}"
echo ""
echo "Or for development:"
echo "flutter run ${DART_DEFINES[*]}"
