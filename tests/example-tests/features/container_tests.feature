@Containers
Feature: Application-Stack is up and running, wired correctly

# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
#
# This will not automatically start images, so please run
#  ./start_example_containers.sh
# for a demo setup. It will not be a functional app, however,
# just for demoing this specification.
#
# tinker with start_example_containers.sh, expose other ports, link
# containers in different ways. execute start script and re-run
# this spec to see what happens.
#
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

Scenario: NGINX Container
  When there is a running container named 'demo_nginx'
  And they should run on image 'nginx:1.7.8'
  And containers should not expose port '80'
  And containers should expose port '443' on host port '8443'
  And container volume '/etc/nginx/sites-enabled' should be mounted
  And container volume '/var/log/nginx' should not be mounted
  And they should be linked to 'demo_node'
  But they should not be linked to 'demo_redis'

Scenario: Node App Container
  When there are running containers named like 'demo_node'
  And they should run on image 'node:0.10.33-slim'
  And containers should expose port '8888'
  And they should be linked to 'demo_redis' with name 'redis'

Scenario: Redis Container
  When there are running containers named like 'redis'
  And they should run on image 'redis:2.8.12'
  And containers should expose port '6379'

Scenario: Security considerations for all
  When there are running containers named like 'demo_'
  Then they should not run privileged
  And containers should not expose port '22'

