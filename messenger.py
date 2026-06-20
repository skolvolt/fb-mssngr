#!/usr/bin/env python3
import os

import gi
gi.require_version("Gtk", "3.0")
from gi.repository import GLib, Gio, Gtk

import webview
from webview.platforms import gtk as _gtk_backend

APP_ID = "com.github.fb-messenger-linux"
GLib.set_prgname(APP_ID)
GLib.set_application_name("Messenger")
Gtk.Window.set_default_icon_name("messenger")

_gtk_backend._app = _gtk_backend.gtk.Application.new(
    APP_ID, Gio.ApplicationFlags.FLAGS_NONE
)

URL = "https://www.facebook.com/messages"

USER_AGENT = (
    "Mozilla/5.0 (X11; Linux x86_64) "
    "AppleWebKit/537.36 (KHTML, like Gecko) "
    "Chrome/126.0.0.0 Safari/537.36"
)


def main() -> int:
    try:
        w, _, h = os.getenv("MESSENGER_WINDOW_SIZE", "1200x860").partition("x")
        width, height = int(w), int(h or 860)
    except ValueError:
        width, height = 1200, 860

    webview.create_window(
        "Messenger",
        URL,
        width=width,
        height=height,
        min_size=(800, 600),
        background_color="#0a0a0a",
        text_select=True,
    )

    webview.start(
        gui="gtk",
        private_mode=False,
        user_agent=USER_AGENT,
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
