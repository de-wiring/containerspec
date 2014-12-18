@Containers
@Valid
Feature: Valid Setup of a container

# Setup
Scenario: Set up container for test case
 Given i rerun container named 'spectest_1' with '-tdi -e TESTKEY1=TESTVALUE1 -v /:/vol:ro -v /tmp:/media -u www-data -p 8080:9090 debian:jessie' 

Scenario: Non privileged
 When there are running containers named like 'spectest'
 And within container HostConfig, 'Privileged' should be 'false'
 And within container HostConfig, 'Privileged' should not be 'true'
  Then it should not run privileged

Scenario: Run off image
 When there are running containers named like 'spectest'
 And within container Config, 'Image' should be 'debian:jessie'
  Then it should run on image 'debian:jessie'
  Then they should run on image 'debian:jessie'

Scenario: Run as user
 When there are running containers named like 'spectest'
 And within container Config, 'User' should be 'www-data'
 Then it should run as user 'www-data'
  And it should not run as user 'root'
  And it should not run as user ''
  And it should not run as root
  And they should not run as user 'root'
  And they should not run as user ''
  And they should not run as root

Scenario: Environment entries
 When there are running containers named like 'spectest'
 And within container Config, 'Env' should be like 'TESTKEY1=TESTVALUE1'
 And within container Config, 'Env' should not be like 'non=existing'
  Then its environment should include 'TESTKEY1'
  Then its environment should not include 'nonexisting'

Scenario: Check Volumes
 When there are running containers named like 'spectest'
 And container 'Volumes' should be like '/media.*/tmp'
 And container 'Volumes' should not be like '/media.*/xyz'
  Then container volume '/media' should be mounted
  Then container volume '/var' should not be mounted
  Then container volume '/vol' should be mounted read-only
  Then container volume '/media' should be mounted to host volume '/tmp'

Scenario: Ports should be exposed
 When there are running containers named like 'spectest'
 And within container NetworkSettings, 'Ports' should be like '9090/tcp'
  Then container should expose port '9090'
  Then container should not expose port '22'
  Then container should expose port '9090' on host port '8080'

Scenario: Set up container for test case
 Given i rerun container named 'spec_linktest_2' with '-tdi --link spectest_1:link1 --volumes-from spectest_1 debian:jessie'
 When there are running containers named like 'spec_linktest'
 And within container HostConfig, 'Links' should be like '/spectest_1:/spec_linktest_2/link1'
  Then it should be linked to 'spectest_1'
  Then it should be linked to 'spectest_1' with name 'link1'

Scenario: Check Volumes-From
  When there are running containers named like 'spec_linktest_2'
  And within container HostConfig, 'VolumesFrom' should be like 'spectest_1'
  And within container HostConfig, 'VolumesFrom' should not be like 'nonexisting'
   Then it should have volumes from 'spectest_1'
   Then it should not have volumes from 'nonex_container'
   Then they should have volumes from 'spectest_1'
   Then they should not have volumes from 'nonex_container'
