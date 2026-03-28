# Laboratorium 5

## Zbudowanie kontenera
```bash
docker build --build-arg VERSION=1.1.0-scratch -t lab5-scratch:v1 .
```

Wynik:
```
[+] Building 6.2s (11/11) FINISHED                           docker:default
 => [internal] load build definition from Dockerfile                   0.0s
 => => transferring dockerfile: 756B                                   0.0s
 => [internal] load metadata for docker.io/library/nginx:alpine        1.1s
 => [auth] library/nginx:pull token for registry-1.docker.io           0.0s
 => [internal] load .dockerignore                                      0.0s
 => => transferring context: 2B                                        0.0s
 => [internal] load build context                                      0.1s
 => => transferring context: 3.51MB                                    0.0s
 => CACHED [stage-1 1/3] FROM docker.io/library/nginx:alpine@sha256:e  0.1s
 => => resolve docker.io/library/nginx:alpine@sha256:e7257f1ef28ba17c  0.1s
 => [builder 1/2] ADD alpine-minirootfs-3.21.3-x86_64.tar.gz /         0.2s
 => [builder 2/2] RUN printf "<html><body>     <h1>Laboratorium 5</h1  0.4s
 => [stage-1 2/3] COPY --from=builder /index.html /usr/share/nginx/ht  0.1s
 => [stage-1 3/3] RUN apk add --no-cache curl                          3.5s
 => exporting to image                                                 0.5s
 => => exporting layers                                                0.2s
 => => exporting manifest sha256:604a18b2ea058f6f8f347c6343078b0cde10  0.0s
 => => exporting config sha256:8b05eeb163676c4a6eb12cd987ab64cb467fbe  0.0s
 => => exporting attestation manifest sha256:2ae1eb5b10da88794f97e4e4  0.1s
 => => exporting manifest list sha256:ec96545eb60375e1f8bebe662cad3f1  0.0s
 => => naming to docker.io/library/lab5-scratch:v1                     0.0s
 => => unpacking to docker.io/library/lab5-scratch:v1                  0.1s
```

## Uruchomienie kontenera
```bash
docker run -d -p 8083:80 --name lab5-container lab5-scratch:v1
```

## Weryfikacja po uruchomieniu kontenera
Po uruchomieniu aplikacja jest dostępna pod adresem http://localhost:8083

Komenda:
```bash
curl -i http://localhost:8083
```

Wynik komendy:
```
HTTP/1.1 200 OK
Server: nginx/1.29.7
Date: Sat, 28 Mar 2026 19:58:08 GMT
Content-Type: text/html
Content-Length: 240
Last-Modified: Sat, 28 Mar 2026 19:47:07 GMT
Connection: keep-alive
ETag: "69c8303b-f0"
Accept-Ranges: bytes

<html><body><h1>Laboratorium 5</h1><p>Wersja: 1.1.0-scratch</p><p>Hostname: <script>document.write(window.location.hostname)</script></p><p>IP: <script>document.write(window.location.host)</script></p></body></html>
```

## Potwierdzenie statusu zdrowia (Healthcheck)
Komenda:
```bash
docker ps --filter name=lab5-container
```

Wynik: 

```
CONTAINER ID   IMAGE             COMMAND                  CREATED          STATUS
664c9dc3ef86   lab5-scratch:v1   "/docker-entrypoint.…"   29 seconds ago   Up 28 seconds (healthy)   0.0.0.0:8083->80/tcp, [::]:8083->80/tcp   lab5-container
```
