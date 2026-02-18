#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: tool/install_and_check.sh <component-id>"
  exit 64
fi

COMPONENT_ID="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
APP_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

REGISTRY_ROOT_DEFAULT="$APP_ROOT/../flutter_shadcn_kit/lib"
CLI_ENTRY_DEFAULT="$APP_ROOT/../../shadcn_flutter_cli/bin/shadcn.dart"

REGISTRY_ROOT="${REGISTRY_ROOT:-$REGISTRY_ROOT_DEFAULT}"
CLI_ENTRY="${CLI_ENTRY:-$CLI_ENTRY_DEFAULT}"

if [[ ! -f "$CLI_ENTRY" ]]; then
  echo "CLI entry not found at: $CLI_ENTRY"
  echo "Set CLI_ENTRY env var to your local shadcn CLI entrypoint."
  exit 1
fi

if [[ ! -f "$REGISTRY_ROOT/registry/components.json" ]]; then
  echo "Registry not found at: $REGISTRY_ROOT"
  echo "Expected file: $REGISTRY_ROOT/registry/components.json"
  echo "Set REGISTRY_ROOT env var if your registry lives elsewhere."
  exit 1
fi

cd "$APP_ROOT"

echo "[1/5] flutter pub get"
flutter pub get

echo "[2/5] CLI init (local registry)"
dart run "$CLI_ENTRY" init --yes \
  --registry local \
  --registry-path "$REGISTRY_ROOT" \
  --install-path lib/ui/shadcn \
  --shared-path lib/ui/shadcn/shared \
  --include-readme \
  --include-meta \
  --include-preview

echo "[3/5] CLI add $COMPONENT_ID"
dart run "$CLI_ENTRY" add "$COMPONENT_ID" \
  --registry local \
  --registry-path "$REGISTRY_ROOT"

echo "[4/5] Byte parity check"
dart run tool/verify_install.dart \
  --component "$COMPONENT_ID" \
  --registry-root "$REGISTRY_ROOT" \
  --project-root "$APP_ROOT"

echo "[5/5] flutter analyze"
set +e
flutter analyze
ANALYZE_EXIT=$?
set -e

if [[ $ANALYZE_EXIT -eq 0 ]]; then
  echo "Validation complete for component: $COMPONENT_ID"
  echo "Result: install parity passed + analyzer clean"
  exit 0
fi

echo "Validation complete for component: $COMPONENT_ID"
echo "Result: install parity passed, analyzer reported issues"
exit "$ANALYZE_EXIT"
