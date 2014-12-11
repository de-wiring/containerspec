#!/bin/bash
TG=dewiring/spec_base
V=0.1
docker build -t $TG:$V .
docker tag $TG:$V $TG:latest

