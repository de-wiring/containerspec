
`spec-cucumber` is a command-container that runs cucumber on features that are
supplied as a volume. It also needs the host's docker socket to be mounted, so it
can run the specification against the host container/image state.

```bash
$ # for convience when calling docker run
$ docker tag dewiring/spec_cucumber:0.1 cucumber:latest

$ cd <to some feature dir>
$ cat simple_example.feature
Feature: Images are ready

Scenario: Nginx
  Given i pull 'nginx'
  When there are images with tags like 'nginx'
  Then 'Author' should be set
  And within Config, 'ExposedPorts' should be like '443/tcp'

$ export DS=/var/run/docker.sock
$ docker run --rm -v `pwd`:/spec -v $DS:$DS cucumber --color
(...)
  Scenario: Test 1                                             # features/x.feature:3
    Given i pull 'nginx'                                       # /project_step_definitions/image_definitions.rb:44
    When there are images with tags like 'nginx'               # /project_step_definitions/image_definitions.rb:70
    Then 'Author' should be set                                # /project_step_definitions/image_definitions.rb:123
    And within Config, 'ExposedPorts' should be like '443/tcp' # /project_step_definitions/image_definitions.rb:139

1 scenario (1 passed)
4 steps (4 passed)
0m1.195s

```

