## Test cases

`core-tests/` folder contains generic test cases to check that the step definitions are correct. It runs on base images (i.e. debian:jessie) and builds a sample image upon that. It includes a serverspec for automatically testing all scenarios:

`example-tests` shows a detailed example for a nginx-node-redis stack. See README there.
