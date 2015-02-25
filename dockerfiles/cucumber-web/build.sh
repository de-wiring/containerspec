#!/bin/bash

TG=dewiring/spec_cucumber_web:0.2
docker build -t $TG .

docker tag -f $TG cucumber_web:latest
