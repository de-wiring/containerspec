#!/bin/bash

NAME=webtest1
docker kill $NAME && docker rm $NAME
docker run -d \
	-p 8080:80 \
	--name $NAME \	
	-v /var/run/docker.sock:/var/run/docker.sock:ro \
	-v /home/vagrant/containerspec:/spec \
	cucumber_web

