#!/bin/bash
ufw --force enable

# Start Tor in background
tor &

# Start nginx in foreground (so container keeps running)
nginx -g "daemon off;"
