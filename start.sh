#!/bin/bash
set -e

# Pantalla virtual
Xvfb :99 -screen 0 1024x768x24 &
export DISPLAY=:99

cleanup() {
    echo "Deteniendo servicios..."
    kill $(jobs -p) 2>/dev/null || true
}

trap cleanup SIGTERM SIGINT

# Doom
chocolate-doom -iwad /usr/share/games/doom/freedoom1.wad &

# Servidor VNC
x11vnc \
    -display :99 -forever -shared -nopw -rfbport 5900 &

# noVNC / WebSocket -> VNC
websockify \
    --web=/usr/share/novnc/ 6080 localhost:5900 &

wait