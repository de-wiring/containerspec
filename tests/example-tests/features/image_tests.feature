Feature: Docker-Stack is pulled and valid

Scenario: NGINX Base Image
  Given i pull 'nginx:1.7.8'
  When there are images tagged 'nginx:1.7.8'
  Then 'Author' should be like 'NGINX Docker Maintainers'
  Then within Config, 'Env' should be set
  Then within Config, 'Env' should be like 'NGINX_VERSION=1.7.8-1~wheezy'
  Then within Config, 'ExposedPorts' should be set
  Then within Config, 'ExposedPorts' should be like '80/tcp'
  Then within Config, 'ExposedPorts' should be like '443/tcp'
  Then within Config, 'Volumes' should be like '/var/cache/nginx'
  Then within Config, 'Cmd' should be like '["nginx", "-g", "daemon off;"]'

Scenario: NodeJS Base Image
  Given i pull 'node:0.10.33-slim'
  When there are images tagged 'node:0.10.33-slim'
  Then within Config, 'Env' should be set
  # ensure a specific version of node
  Then within Config, 'Env' should be like 'NODE_VERSION=0.10.33'
  # ensure that npm version is set, but do not care about a specific one
  Then within Config, 'Env' should be like 'NPM_VERSION'
  Then within Config, 'ExposedPorts' should not be set
  Then within Config, 'Cmd' should be like '["node"]'

Scenario: Redis Base Image
  Given i pull 'redis:2.8.12'
  When there are images tagged 'redis:2.8.12'
  Then within Config, 'Env' should be like 'REDIS_VERSION=2.8.12'
  Then within Config, 'Env' should be like 'REDIS_DOWNLOAD_URL.*http://download.redis.io/'
  Then within Config, 'Env' should be like 'REDIS_DOWNLOAD_SHA1'
  Then within Config, 'ExposedPorts' should be like '6379/tcp'
  Then within Config, 'Volume' should be set
  Then within Config, 'Workdir' should be set
  Then within Config, 'Workdir' should be '/data'
  Then within Config, 'Cmd' should be like '["redis-server"]'