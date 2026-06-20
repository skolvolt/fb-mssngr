# fb-messenger-linux

A lightweight native Linux desktop app for Facebook Messenger, built with **pywebview + WebKitGTK** — no Electron, no Chromium, no snap required.

![Messenger running on Linux](icons/messenger.png)

## Why?

- The official Messenger website works great but there's no native Linux app
- Existing wrappers (Caprine, etc.) use Electron which is heavy
- This uses the system's WebKitGTK renderer — fast, lightweight, and native GTK

## Requirements

- Ubuntu 22.04+ / Debian 12+ / Linux Mint 21+ (or any distro with WebKitGTK 4.0)
- Python 3.10+

## Install

```bash
git clone https://github.com/skolvolt/fb-messenger-linux.git
cd fb-messenger-linux
chmod +x install.sh
./install.sh
```

That's it. Launch **Messenger** from your app grid or dock.

## Uninstall

```bash
chmod +x uninstall.sh
./uninstall.sh
```

## Manual run (without installing)

```bash
sudo apt install python3-webview gir1.2-webkit2-4.0
python3 messenger.py
```

## Window size

Override with the `MESSENGER_WINDOW_SIZE` environment variable:

```bash
MESSENGER_WINDOW_SIZE=1440x900 python3 messenger.py
```

## Notes

- Your login session is saved — you only need to log in once
- Sessions are stored in `~/.local/share/com.github.fb-messenger-linux/`
- Tested on Ubuntu 24.04 LTS and POP!_OS 22.04 with COSMIC desktop

## How it works

Uses [pywebview](https://pywebview.flowrl.com/) to wrap `https://www.facebook.com/messages` in a native GTK window via WebKitGTK. A custom user-agent string ensures Facebook serves the full web interface instead of a mobile fallback.

## License

MIT
