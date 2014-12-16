@Containers
@Valid
Feature: Valid Setup of a container

# Setup
Scenario: Set up container for test case
 Given i rerun container named 'spectest_1' with '-tdi -e TESTKEY1=TESTVALUE1 -v /:/vol:ro -v /tmp:/media -p 8080:9090 debian:jessie' 

Scenario: Non privileged
 When there are running containers named like 'spectest'
 Then within container HostConfig, 'Privileged' should be 'false'
 Then within container HostConfig, 'Privileged' should not be 'true'
 And it should not run privileged

Scenario: Environment entries
 When there are running containers named like 'spectest'
 Then within container Config, 'Env' should be like 'TESTKEY1=TESTVALUE1'
 Then within container Config, 'Env' should not be like 'non=existing'
 And its environment should include 'TESTKEY1'
 And its environment should not include 'nonexisting'

Scenario: Check Volumes
 When there are running containers named like 'spectest'
 Then container 'Volumes' should be like '/media.*/tmp'
 Then container 'Volumes' should not be like '/media.*/xyz'
 And container volume '/media' should be mounted
 And container volume '/var' should not be mounted
 And container volume '/vol' should be mounted read-only
 And container volume '/media' should be mounted to host volume '/tmp'

Scenario: Ports should be exposed
 When there are running containers named like 'spectest'
 Then within container NetworkSettings, 'Ports' should be like '9090/tcp'
 And container should expose port '9090'
 And container should not expose port '22'
 And container should expose port '9090' on host port '8080'



