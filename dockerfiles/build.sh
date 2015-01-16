#!/bin/bash

# build all
IMAGES="specbase cucumber cucumber-web serverspec"
for IMAGE in $IMAGES; do
	( cd $IMAGE && ./build.sh )
done

