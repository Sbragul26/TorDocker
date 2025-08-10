#To build the container in x86_T64 Architecture...
#=================================================

FROM archlinux:latest

ENV TZ=Asia/Dhaka

RUN pacman -Syu --noconfirm && \
    ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    pacman -S --noconfirm tor nginx nano shadow && \
    pacman -Scc --noconfirm

RUN mkdir -p /var/lib/tor/hidden_service && \
    chown -R tor:tor /var/lib/tor/hidden_service && \
    chmod 700 /var/lib/tor/hidden_service

COPY torrc /etc/tor/torrc
COPY nginx.conf /etc/nginx/nginx.conf

COPY service_start.sh /service_start.sh
RUN chmod +x /service_start.sh

EXPOSE 80 443 9050

ENTRYPOINT ["/service_start.sh"]
