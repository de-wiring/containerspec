#!/bin/bash
TG=dewiring/spec_base
V=0.2
docker build --rm --no-cache --force-rm -t $TG:$V .
docker tag $TG:$V $TG:latest

