# builder
FROM scratch AS builder
ADD alpine-minirootfs-3.21.3-x86_64.tar.gz /

ARG VERSION
ENV APP_VERSION=$VERSION

# tworzenie index.html
RUN printf "<html><body> \
    <h1>Laboratorium 5</h1> \
    <p>Wersja: ${APP_VERSION}</p> \
    <p>Hostname: <script>document.write(window.location.hostname)</script></p> \
    <p>IP: <script>document.write(window.location.host)</script></p> \
    </body></html>" > /index.html

# serwer docelowy
FROM nginx:alpine

# kopia pliku z poprzedniego etapu
COPY --from=builder /index.html /usr/share/nginx/html/index.html

# curl i healthcheck
RUN apk add --no-cache curl
HEALTHCHECK --interval=10s --timeout=3s --start-period=5s --retries=3 CMD curl -f http://localhost/ || exit 1