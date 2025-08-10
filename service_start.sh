#!/bin/bash

# Enable UFW and set security rules
echo "Configuring firewall with UFW..."
ufw --force reset
ufw default deny incoming
ufw default allow outgoing

# Allow only HTTP for nginx inside container
ufw allow 80/tcp
# Tor will listen internally, so no need to expose its ports

ufw --force enable
# Stop any running nginx (safety)
nginx -s stop 2>/dev/null || true

# Start nginx in background
nginx

# Start Tor as 'tor' user
runuser -u tor -- tor -f /etc/tor/torrc &

# Wait for Onion address
echo "Waiting for Tor to create the hidden service hostname..."
while [ ! -f /var/lib/tor/hidden_service/hostname ]; do
    sleep 1
done

ONION_ADDR=$(cat /var/lib/tor/hidden_service/hostname)

echo "======================================"
echo "Tor Onion Service is live!"
echo "🌐 Address: $ONION_ADDR"
echo "======================================"

# Keep container running
tail -f /dev/null
