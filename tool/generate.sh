#!/usr/bin/env bash
set -euo pipefail

echo "==> Installing Flutter dependencies"
flutter pub get

echo "==> Generating localization"
dart run slang

echo "==> Running build_runner"
dart run build_runner build --delete-conflicting-outputs

echo "==> Generation complete"
