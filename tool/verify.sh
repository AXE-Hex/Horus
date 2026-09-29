#!/usr/bin/env bash
set -euo pipefail

readonly SUPABASE_CLI_VERSION="2.118.0"
readonly FLUTTER_VERSION="3.44.4"

command -v flutter >/dev/null || { echo "Flutter is required." >&2; exit 1; }
command -v dart >/dev/null || { echo "Dart is required." >&2; exit 1; }
command -v npx >/dev/null || { echo "Node.js/npm are required for the local Supabase CLI." >&2; exit 1; }

flutter --version | head -n 1 | grep -F "Flutter ${FLUTTER_VERSION} " >/dev/null || {
  echo "This repository is locked for Flutter ${FLUTTER_VERSION}; install that stable SDK first." >&2
  exit 1
}

flutter pub get --enforce-lockfile
dart run build_runner build
dart run slang
git diff --exit-code -- lib
test -z "$(git ls-files --others --exclude-standard -- lib)"
dart format --output=none --set-exit-if-changed lib test
flutter analyze
dart run custom_lint
flutter test
flutter test --coverage
flutter build apk --debug
flutter build web --release

supabase() {
  npx --yes "supabase@${SUPABASE_CLI_VERSION}" "$@"
}

if supabase status >/dev/null 2>&1; then
  echo "A local Supabase stack is already running; refusing to stop or reset it." >&2
  exit 1
fi

cleanup() {
  supabase stop || true
}
trap cleanup EXIT
supabase start
supabase db reset --local
supabase test db --local
supabase db lint --local
