FROM debian:12-slim

ENV PATH="/usr/games:${PATH}"

RUN apt-get update && \
    apt-get install -y chocolate-doom freedoom xvfb x11vnc novnc websockify && \
    rm -rf /var/lib/apt/lists/*

COPY start.sh /start.sh

RUN chmod +x /start.sh

CMD ["/start.sh"]