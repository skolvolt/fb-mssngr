#!/usr/bin/env bash
set -euo pipefail

echo "==> Removing fb-messenger-linux..."

rm -rf "$HOME/.local/share/fb-messenger-linux"
rm -f "$HOME/.local/share/applications/fb-messenger.desktop"
rm -f "$HOME/.local/share/icons/messenger.png"

for size in 16 24 32 48 64 96 128 256 512; do
    rm -f "$HOME/.local/share/icons/hicolor/${size}x${size}/apps/messenger.png"
done

update-desktop-database "$HOME/.local/share/applications/" 2>/dev/null || true
gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" 2>/dev/null || true

echo "Done. Messenger has been removed."
