#!/bin/bash

# copy over spec to working dir
cp -rp /spec/* /serverspec/spec/localhost/
/usr/local/bin/rake spec $@

