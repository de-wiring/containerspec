# example-tests

This test suite covers a more read-life example with images from nginx, nodejs and redis.
Images are being pulled when called for the first time, so that might take a while.

```cucumber
$ cucumber
Feature: Docker-Stack is pulled and valid

  Scenario: NGINX Base Image                                                  # features/image_tests.feature:3
    Given i pull 'nginx:1.7.8'                                                # features/step_definitions/image_definitions.rb:52
    When there are images tagged 'nginx:1.7.8'                                # features/step_definitions/image_definitions.rb:79
    Then 'Author' should be like 'NGINX Docker Maintainers'                   # features/step_definitions/image_definitions.rb:106
    Then within Config, 'Env' should be set                                   # features/step_definitions/image_definitions.rb:182
    Then within Config, 'Env' should be like 'NGINX_VERSION=1.7.8-1~wheezy'   # features/step_definitions/image_definitions.rb:139
    Then within Config, 'ExposedPorts' should be set                          # features/step_definitions/image_definitions.rb:182
    Then within Config, 'ExposedPorts' should be like '80/tcp'                # features/step_definitions/image_definitions.rb:139
    Then within Config, 'ExposedPorts' should be like '443/tcp'               # features/step_definitions/image_definitions.rb:139
    Then within Config, 'Volumes' should be like '/var/cache/nginx'           # features/step_definitions/image_definitions.rb:139
    Then within Config, 'Cmd' should be like '["nginx", "-g", "daemon off;"]' # features/step_definitions/image_definitions.rb:139

  Scenario: NodeJS Base Image                                       # features/image_tests.feature:15
    Given i pull 'node:0.10.33-slim'                                # features/step_definitions/image_definitions.rb:52
    When there are images tagged 'node:0.10.33-slim'                # features/step_definitions/image_definitions.rb:79
    Then within Config, 'Env' should be set                         # features/step_definitions/image_definitions.rb:182
    Then within Config, 'Env' should be like 'NODE_VERSION=0.10.33' # features/step_definitions/image_definitions.rb:139

    Then within Config, 'Env' should be like 'NPM_VERSION'          # features/step_definitions/image_definitions.rb:139
    Then within Config, 'ExposedPorts' should not be set            # features/step_definitions/image_definitions.rb:191
    Then within Config, 'Cmd' should be like '["node"]'             # features/step_definitions/image_definitions.rb:139

  Scenario: Redis Base Image                                                                 # features/image_tests.feature:26
    Given i pull 'redis:2.8.12'                                                              # features/step_definitions/image_definitions.rb:52
    When there are images tagged 'redis:2.8.12'                                              # features/step_definitions/image_definitions.rb:79
    Then within Config, 'Env' should be like 'REDIS_VERSION=2.8.12'                          # features/step_definitions/image_definitions.rb:139
    Then within Config, 'Env' should be like 'REDIS_DOWNLOAD_URL.*http://download.redis.io/' # features/step_definitions/image_definitions.rb:139
    Then within Config, 'Env' should be like 'REDIS_DOWNLOAD_SHA1'                           # features/step_definitions/image_definitions.rb:139
    Then within Config, 'ExposedPorts' should be like '6379/tcp'                             # features/step_definitions/image_definitions.rb:139
    Then within Config, 'Volume' should be set                                               # features/step_definitions/image_definitions.rb:182
    Then within Config, 'Workdir' should be set                                              # features/step_definitions/image_definitions.rb:182
    Then within Config, 'Workdir' should be '/data'                                          # features/step_definitions/image_definitions.rb:162
    Then within Config, 'Cmd' should be like '["redis-server"]'                              # features/step_definitions/image_definitions.rb:139

3 scenarios (3 passed)
27 steps (27 passed)
0m3.376s
```

