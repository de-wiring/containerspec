#!/bin/bash
TG=de_wiring/spec_base
V=0.1
docker build -t $TG:$V .
docker tag $TG:$V $TG:latest

