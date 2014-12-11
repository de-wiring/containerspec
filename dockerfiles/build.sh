#!/bin/bash

# build all
IMAGES="specbase cucumber serverspec"
for IMAGE in $IMAGES; do
	( cd $IMAGE && ./build.sh )
done

