#!/bin/bash

TG=dewiring/spec_serverspec:0.2
docker build --rm --no-cache --force-rm -t $TG .
docker tag -f $TG serverspec:latest

