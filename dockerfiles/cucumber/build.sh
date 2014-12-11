#!/bin/bash

# copy over step definitions to here, we cannot add links in dockerfile
cp -rf /spec_dockerbox/project_step_definitions .

TG=de_wiring/spec_cucumber:0.1
docker build -t $TG .

# for convenience, tag this as cucumber, so we can docker run cucumber ...
docker tag $TG cucumber:latest

