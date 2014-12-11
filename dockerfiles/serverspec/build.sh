#!/bin/bash

TG=dewiring/spec_serverspec:0.1
docker build -t $TG .
docker tag $TG serverspec:latest

