#!/usr/bin/env bash
set -euo pipefail

echo "Checking repository hygiene..."

blocked_patterns=(
  '(^|/)\.env($|\.)'
  '(^|/)key\.properties$'
  '(^|/)local\.properties$'
  '\.(jks|keystore|p12|pem|key)$'
  '(^|/)build/'
  '(^|/)\.dart_tool/'
  '(^|/)coverage/'
  '\.g\.dart$'
  '\.freezed\.dart$'
  '\.gr\.dart$'
  '\.gen\.dart$'
)

fail=0

while IFS= read -r file; do
  [[ "$file" == ".env.example" ]] && continue

  for pattern in "${blocked_patterns[@]}"; do
    if [[ "$file" =~ $pattern ]]; then
      echo "Blocked tracked file: $file"
      fail=1
      break
    fi
  done
done < <(git ls-files)

if [[ "$fail" -ne 0 ]]; then
  echo "Repository hygiene check failed."
  exit 1
fi

echo "Repository hygiene check passed."
