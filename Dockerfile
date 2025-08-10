# Builds the Arch Linux tiny image, installs Tor, nginx, UFW, copies configs, and sets up the entrypoint.

# Use lightweight Arch Linux base image
FROM yantis/archlinux-tiny

# Set environment variables (you can customize timezone if needed)
ENV TZ=UTC

# Update system and install required packages: tor, nginx, ufw, bash, curl, and base-devel utilities
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm tor nginx ufw iptables bash curl && \
    pacman -Scc --noconfirm

# Enable systemd inside container (optional, but we can run services manually)
# Note: Archlinux-tiny is very minimal; no systemd by default, so we will run daemons manually

# Configure Tor Hidden Service directory and permissions
RUN mkdir -p /var/lib/tor/hidden_service && \
    chown -R tor:tor /var/lib/tor

# Copy default nginx config placeholder
RUN mkdir -p /etc/nginx/sites-enabled /var/www/html
COPY index.html /var/www/html/index.html

# Setup UFW default rules
RUN ufw default deny incoming && \
    ufw default allow outgoing && \
    ufw allow 22/tcp && \
    ufw allow 80/tcp && \
    ufw allow 443/tcp

# Expose ports (optional, Tor usually listens internally)
EXPOSE 22 80 443

# Add startup script to run Tor, nginx and enable UFW
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Use bash entrypoint
CMD ["/start.sh"]
