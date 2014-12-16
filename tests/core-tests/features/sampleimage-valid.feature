# This file describes valid scenarios based upon
# our own sample image

@Images
@SampleImage

@Valid
Feature: Valid clauses work

Scenario: Sample image tests, valid clauses
  When there are images tagged 'de_wiring/sampleimage:latest'
  Then 'Author' should be 'test.maintainer@de-wiring.net'
  Then within Config, 'User' should be set
  Then within Config, 'User' should be 'vagrant'
  Then within Config, 'Env' should be like 'TESTKEY1=TESTENTRY1'
  Then within Config, 'Env' should be like 'TESTKEY2=TESTENTRY2'
  Then within Config, 'Env' should not be like 'TESTKEY3=TESTENTRY3'
  Then within Config, 'ExposedPorts' should be like '80/tcp'
  Then within Config, 'ExposedPorts' should be like '443/tcp'
  Then within Config, 'ExposedPorts' should not be like '22/tcp'
  Then within Config, 'Cmd' should be like 'test'
  Then within Config, 'Cmd' should not be like 'invalid'
  Then within Config, 'Entrypoint' should be '["/bin/test", "-c"]'
  Then within Config, 'Entrypoint' should not be '["/bin/bash", "-c"]'
