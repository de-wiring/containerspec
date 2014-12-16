@Containers
@Invalid
Feature: Invalid clauses for a container setup

# Setup
Scenario: Set up container for test case
 Given i rerun container named 'spectest_1' with '-tdi -e TESTKEY1=TESTVALUE1 -v /:/vol:ro -v /tmp:/media -p 8080:9090 debian:jessie'
 When there are running containers named like 'nonexisting'

Scenario: Non privileged
 When there are running containers named like 'spectest'
 Then within container HostConfig, 'Privileged' should not be 'false'

Scenario: Non privileged
 When there are running containers named like 'spectest'
 Then within container HostConfig, 'Privileged' should be 'true'

Scenario: Non privileged
 When there are running containers named like 'spectest'
 Then it should run privileged

Scenario: Environment entries
 When there are running containers named like 'spectest'
 Then within container Config, 'Env' should not be like 'TESTKEY1=TESTVALUE1'

Scenario: Environment entries
 When there are running containers named like 'spectest'
 Then within container Config, 'Env' should be like 'non=existing'

Scenario: Environment entries
 When there are running containers named like 'spectest'
 Then its environment should not include 'TESTKEY1'

Scenario: Environment entries
 When there are running containers named like 'spectest'
 Then its environment should include 'nonexisting'

Scenario: Check Volumes
 When there are running containers named like 'spectest'
 Then container 'Volumes' should not be like '/media.*/tmp'

Scenario: Check Volumes
 When there are running containers named like 'spectest'
 Then container 'Volumes' should be like '/media.*/xyz'

Scenario: Check Volumes
 When there are running containers named like 'spectest'
 Then container volume '/media' should not be mounted

Scenario: Check Volumes
 When there are running containers named like 'spectest'
 Then container volume '/var' should be mounted

Scenario: Ports should be exposed
 When there are running containers named like 'spectest'
 Then within container NetworkSettings, 'Ports' should not be like '9090/tcp'

Scenario: Ports should be exposed
 When there are running containers named like 'spectest'
 Then container should not expose port '9090'

Scenario: Ports should be exposed
 When there are running containers named like 'spectest'
 Then container should expose port '22'




