which docker >/dev/null 2>&1
if [[ $? -ne 0 ]]; then 
	curl -sSL https://get.docker.com/ | sh
	docker info
fi

gpasswd -a vagrant docker

# pull us some images to play with
docker pull debian:jessie
docker pull busybox:latest
docker pull scratch:latest

