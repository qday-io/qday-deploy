# QDay Explorer

## Blockscout

```bash
mkdir -p ~/deploy
cd ~/deploy
git clone https://github.com/qday-io/qday-explorer-blockscout.git blockscout
cd blockscout
git log -1 --format="%H" # 8382c357f4240b3e3c7704d2fb88986d685b0a6f
cd docker-compose
mv docker-compose.yml docker-compose.yml.old
cp geth.yml docker-compose.yml

$ vim docker-compose.yml
# Comment out the frontend service
#  frontend:
#    depends_on:
#      - backend
#    extends:
#      file: ./services/frontend.yml
#      service: frontend
...
  proxy:
    depends_on:
      - backend
#      - frontend

$ vim envs/common-blockscout.env
ETHEREUM_JSONRPC_HTTP_URL=https://rpc-0.qday.info
ETHEREUM_JSONRPC_TRACE_URL=https://rpc-0.qday.info
SUBNETWORK=QDay
CHAIN_ID=44003

$ vim proxy/default.conf.template
    listen       10080;

$ vim services/backend.yml
    # Add these lines under "logging:"
    logging:
       driver: "json-file"
       options:
        max-size: "500m"
        max-file: "3"

$ vim services/nginx.yml
      FRONT_PROXY_PASS: ${FRONT_PROXY_PASS:-http://frontend:3000}
      # Change to
      FRONT_PROXY_PASS: ${FRONT_PROXY_PASS:-http://FRONTEND_HOSTNAME:3000}
...
      - target: 80
        published: 80
      # Change to
      - target: 10080
        published: 10080

docker compose up -d
```

> services/backend.yml Blockscout version change to 6.9.2

## Blockscout Frontend

```bash
cd ~/deploy
git clone https://github.com/qday-io/qday-explorer-frontend.git explorer-frontend
cd explorer-frontend

docker build \
  --build-arg GIT_COMMIT_SHA=$(git rev-parse --short HEAD) \
  --build-arg GIT_TAG=$(git describe --tags --abbrev=0) \
  -t explorer-frontend:local \
  ./

$ vim compose.yml
services:

  frontend:
    image: explorer-frontend:local
    platform: linux/amd64
    restart: always
    container_name: 'frontend'
    network_mode: host
    env_file:
      - .env

$ vim .env
NEXT_PUBLIC_API_HOST=explorer.qday.info
NEXT_PUBLIC_API_PROTOCOL=https
NEXT_PUBLIC_NETWORK_NAME=QDay
NEXT_PUBLIC_NETWORK_SHORT_NAME=QDay
NEXT_PUBLIC_NETWORK_ID=44003
NEXT_PUBLIC_STATS_API_HOST=https://explorer.qday.info
NEXT_PUBLIC_VISUALIZE_API_HOST=https://explorer.qday.info
NEXT_PUBLIC_APP_HOST=https://explorer.qday.info
HOSTNAME=0.0.0.0
NEXT_PUBLIC_APP_PORT=3000
NEXT_PUBLIC_WALLET_CONNECT_PROJECT_ID=<your-secret>
NEXT_PUBLIC_NETWORK_CURRENCY_NAME=QDAY
NEXT_PUBLIC_NETWORK_CURRENCY_SYMBOL=QDAY
NEXT_PUBLIC_NETWORK_CURRENCY_DECIMALS=18
NEXT_PUBLIC_API_BASE_PATH=/
NEXT_PUBLIC_APP_PROTOCOL=https
NEXT_PUBLIC_IS_TESTNET=true
NEXT_PUBLIC_API_WEBSOCKET_PROTOCOL=wss
NEXT_PUBLIC_HOMEPAGE_CHARTS=['daily_txs']
NEXT_PUBLIC_API_SPEC_URL=https://raw.githubusercontent.com/blockscout/blockscout-api-v2-swagger/main/swagger.yaml
NEXT_PUBLIC_NAVIGATION_LAYOUT=horizontal
NEXT_PUBLIC_COLOR_THEME_DEFAULT=dark

$ docker compose up -d
```

## NGINX

```bash
$ mkdir -p ~/deploy/nginx/templates/
$ cd ~/deploy/nginx

$ vim compose.yml
services:

  nginx:
    image: nginx:alpine
    container_name: nginx
    network_mode: host
    restart: always
    volumes:
     - ./templates:/etc/nginx/templates:ro

$ vim templates/explorer.conf.template
server {
    listen 80;
    server_name explorer.qday.info;

    # Handle /api/v1/lines and /api/v1/counters
    location ~ ^/api/v1/(lines|counters) {
        proxy_pass http://localhost:8080;
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

    location / {
        proxy_pass http://127.0.0.1:10080/;
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

$ docker compose up -d
```

Open your browser to https://explorer.qday.info and you will see the Blockscout explorer.

