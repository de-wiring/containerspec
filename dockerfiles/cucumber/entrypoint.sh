#!/bin/bash
# will copy features to /cucumber dir and run cucumber, auto-requiring our
# step definitions

mkdir /cucumber
mkdir /cucumber/features
cp -rp /spec/* /cucumber/features/
cd /cucumber
/usr/local/bin/cucumber --require /project_step_definitions $@

