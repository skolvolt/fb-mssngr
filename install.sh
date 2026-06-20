#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="$HOME/.local/share/fb-messenger-linux"
ICON_SIZES=(16 24 32 48 64 96 128 256 512)

echo "==> Installing dependencies (requires sudo)..."
sudo apt-get install -y python3-webview gir1.2-webkit2-4.0

echo "==> Installing app files..."
mkdir -p "$INSTALL_DIR"
cp messenger.py "$INSTALL_DIR/messenger.py"
chmod +x "$INSTALL_DIR/messenger.py"

echo "==> Installing icons..."
for size in "${ICON_SIZES[@]}"; do
    icon_dir="$HOME/.local/share/icons/hicolor/${size}x${size}/apps"
    mkdir -p "$icon_dir"
    if command -v convert &>/dev/null; then
        convert icons/messenger.png -resize "${size}x${size}" "$icon_dir/messenger.png" 2>/dev/null || \
            cp icons/messenger.png "$icon_dir/messenger.png"
    else
        cp icons/messenger.png "$icon_dir/messenger.png"
    fi
done
cp icons/messenger.png "$HOME/.local/share/icons/messenger.png"

echo "==> Creating .desktop launcher..."
DESKTOP_FILE="$HOME/.local/share/applications/fb-messenger.desktop"
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=Messenger
Comment=Facebook Messenger native desktop app
Icon=messenger
Exec=python3 $INSTALL_DIR/messenger.py
Terminal=false
Categories=Network;InstantMessaging;
StartupWMClass=com.github.fb-messenger-linux
StartupNotify=true
EOF

echo "==> Updating desktop database..."
update-desktop-database "$HOME/.local/share/applications/" 2>/dev/null || true
gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" 2>/dev/null || true

echo ""
echo "Done! Launch 'Messenger' from your app grid or run:"
echo "  python3 $INSTALL_DIR/messenger.py"
