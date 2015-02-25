#!/bin/bash

# copy over step definitions to here, we cannot add links in dockerfile
cp -rf /spec_dockerbox/project_step_definitions .

TG=dewiring/spec_cucumber:0.2
docker build -t $TG .

# for convenience, tag this as cucumber, so we can docker run cucumber ...
docker tag -f $TG cucumber:latest

