# ZKVM RPC Proxy

> Host: qday-sg-01

Create the directory for the Nginx templates.

```bash
$ mkdir -p ~/deploy/nginx/templates/
$ cd ~/deploy/nginx
```

Create the Nginx template file.

```bash
$ vim templates/zkevm-rpc-proxy.conf.template
server {
    listen 18123;
    server_name _;

    location / {
        proxy_pass http://159.138.82.123:8123/;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_read_timeout 43200000;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Host $http_host;
        proxy_set_header X-NginX-Proxy true;
    }
}
```

Create the Docker Compose file.

```bash
$ vim docker-compose.yml
services:

  nginx:
    image: nginx:alpine
    container_name: nginx
    restart: always
    network_mode: host
    volumes:
     - ./templates:/etc/nginx/templates:ro
```

Start the Nginx container.

```bash
$ docker compose up -d
```

Test the connection to the ZKVM RPC proxy.

```bash
curl -X POST http://localhost:18123 \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0", "method":"eth_blockNumber", "params":[], "id":1}'
```
