#!/bin/bash

TG=dewiring/spec_cucumber_web:0.1
docker build -t $TG .

docker tag $TG cucumber_web:latest
