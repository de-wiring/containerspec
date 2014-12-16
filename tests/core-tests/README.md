
# core-tests

To test the step definitions we need run run several sections/tags with cucumber

 * We can run @Images tests and/or @Container tests
 * @Valid tests are required to pass, because they describe valid features within images/containers
 * @Invalid tests are required to fail, because they describe invalid features within images/containers
 * when offline, run only ~@Registry, so `docker pull` commands are bypassed
 * a sample image can be tested with @SampleImage (combined with @Valid/@Invalid as well)

```bash
$ cd /spec_dockerbox/tests/core-tests
$ cucumber --tags @Valid --tags @Images
(...)

11 scenarios (11 passed)
45 steps (45 passed)
0m8.209s

$ cucumber --tags @Invalid --tags @Images
(...)

39 scenarios (39 failed)

$ cucumber --tags @Valid --tags @SampleImage
(...)
1 scenario (1 passed)
14 steps (14 passed)
0m0.105s


$ cucumber --tags @Valid --tags @SampleImage
(...)
13 scenarios (13 failed)
```

This can be automated by using serverspec (it works on top of cucumber):

```bash
$ rake spec
(...)


Finished in 13.94 seconds (files took 0.42859 seconds to load)
12 examples, 0 failures
```

