
# example-tests

This test suite covers a more real-life example with images from nginx, nodejs and redis.

## Images

Images are being pulled when called for the first time, so that might take a while.

```cucumber
$ cucumber --tags @Images
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

## Container

`start_example_containers.sh` takes the above images and start containers with parameters and links them
together. This script can be run multiple times, it will kill running containers with same names before 
starting them.

This is not a functional application but serves only as a base for demonstrating the container spec
capabilities:

```bash
vagrant@dewiring-debian-7:/spec_dockerbox/tests/example-tests$ cucumber --tags @Containers
@Containers
Feature: Application-Stack is up and running, wired correctly
(...)
  Scenario: NGINX Container                                           # features/container_tests.feature:17
    When there is a running container named 'demo_nginx'              # features/step_definitions/container_definitions.rb:29
    And they should run on image 'nginx:1.7.8'                        # features/step_definitions/container_definitions.rb:240
    And containers should not expose port '80'                        # features/step_definitions/container_definitions.rb:230
    And containers should expose port '443' on host port '8443'       # features/step_definitions/container_definitions.rb:213
    And container volume '/etc/nginx/sites-enabled' should be mounted # features/step_definitions/container_definitions.rb:167
    And container volume '/var/log/nginx' should not be mounted       # features/step_definitions/container_definitions.rb:185
    And they should be linked to 'demo_node'                          # features/step_definitions/container_definitions.rb:305
    But they should not be linked to 'demo_redis'                     # features/step_definitions/container_definitions.rb:320

  Scenario: Node App Container                                  # features/container_tests.feature:27
    When there are running containers named like 'demo_node'    # features/step_definitions/container_definitions.rb:37
    And they should run on image 'node:0.10.33-slim'            # features/step_definitions/container_definitions.rb:240
    And containers should expose port '8888'                    # features/step_definitions/container_definitions.rb:203
    And they should be linked to 'demo_redis' with name 'redis' # features/step_definitions/container_definitions.rb:290

  Scenario: Redis Container                              # features/container_tests.feature:33
    When there are running containers named like 'redis' # features/step_definitions/container_definitions.rb:37
    And they should run on image 'redis:2.8.12'          # features/step_definitions/container_definitions.rb:240
    And containers should expose port '6379'             # features/step_definitions/container_definitions.rb:203

  Scenario: Security considerations for all              # features/container_tests.feature:38
    When there are running containers named like 'demo_' # features/step_definitions/container_definitions.rb:37
    Then they should not run privileged                  # features/step_definitions/container_definitions.rb:117
    And containers should not expose port '22'           # features/step_definitions/container_definitions.rb:230

4 scenarios (4 passed)
18 steps (18 passed)
0m0.156s
```

Modifying the start script one can play around with this example and see what happens
to the spec when containers are run in a different way (i.e. wrong linking, wrong ports, wrong names etc.)

