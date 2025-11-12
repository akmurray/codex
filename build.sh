#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
BACKEND_DIR="/mnt/c/CoeusLocalOfflineWeb1/backend"
BACKEND_BIN_DIR="$BACKEND_DIR/dist/bin"
TARGET_DIR="$ROOT_DIR/codex-rs/target/release"
SOURCE_NAME="codex"
DEST_NAME="codex-coeus"

cd "$ROOT_DIR/codex-rs"

cargo build --release --locked

mkdir -p "$BACKEND_BIN_DIR"

copy_binary() {
  local src="$1"
  local dest="$2"
  if [[ -f "$src" ]]; then
    cp -- "$src" "$dest"
    chmod 755 "$dest"
    echo "copied $(basename "$src") to $dest"
    return 0
  fi
  return 1
}

copy_binary "$TARGET_DIR/$SOURCE_NAME" "$BACKEND_BIN_DIR/$DEST_NAME"
copy_binary "$TARGET_DIR/$SOURCE_NAME.exe" "$BACKEND_BIN_DIR/$DEST_NAME.exe"
