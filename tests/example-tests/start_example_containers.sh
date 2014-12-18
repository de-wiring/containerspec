#!/bin/bash

( docker stop demo_redis && docker rm demo_redis ) >/dev/null 2>&1
docker run \
	--detach \
	--name "demo_redis" \
	-P \
 	redis:2.8.12

( docker stop demo_node && docker rm demo_node ) >/dev/null 2>&1
docker run \
	--detach \
	--name "demo_node" \
	-p 8888:8888 \
        --link demo_redis:redis \
        -v `pwd`:/usr/src/myapp -w /usr/src/myapp \
	node:0.10.33-slim node helloworld.js

( docker stop demo_nginx && docker rm demo_nginx ) >/dev/null 2>&1
docker run \
	--detach \
	--name "demo_nginx" \
	-v `pwd`:/etc/nginx/sites-enabled \
	-p 8443:443 \
	--link demo_node:app \
	nginx:1.7.8

