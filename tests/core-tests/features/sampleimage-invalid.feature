# This file describes valid scenarios based upon
# our own sample image

@SampleImage

@Invalid
Feature: Invalid clauses will fail

Scenario: Sample image tests, invalid clauses
  When there are images tagged 'de_wiring/sampleimage:latest'
  Then 'Author' should be 'invalid.maintainer@de-wiring.net'
Scenario: Sample image tests, invalid clauses
  When there are images tagged 'de_wiring/sampleimage:latest'
  Then within Config, 'User' should not be set
Scenario: Sample image tests, invalid clauses
  When there are images tagged 'de_wiring/sampleimage:latest'
  Then within Config, 'User' should not be 'vagrant'
Scenario: Sample image tests, invalid clauses
  When there are images tagged 'de_wiring/sampleimage:latest'
  Then within Config, 'Env' should not be like 'TESTKEY1=TESTENTRY1'
Scenario: Sample image tests, invalid clauses
  When there are images tagged 'de_wiring/sampleimage:latest'
  Then within Config, 'Env' should not be like 'TESTKEY2=TESTENTRY2'
Scenario: Sample image tests, invalid clauses
  When there are images tagged 'de_wiring/sampleimage:latest'
  Then within Config, 'Env' should be like 'TESTKEY3=TESTENTRY3'
Scenario: Sample image tests, invalid clauses
  When there are images tagged 'de_wiring/sampleimage:latest'
  Then within Config, 'ExposedPorts' should not be like '80/tcp'
Scenario: Sample image tests, invalid clauses
  When there are images tagged 'de_wiring/sampleimage:latest'
  Then within Config, 'ExposedPorts' should not be like '443/tcp'
Scenario: Sample image tests, invalid clauses
  When there are images tagged 'de_wiring/sampleimage:latest'
  Then within Config, 'ExposedPorts' should be like '22/tcp'
Scenario: Sample image tests, invalid clauses
  When there are images tagged 'de_wiring/sampleimage:latest'
  Then within Config, 'Cmd' should not be like 'test'
Scenario: Sample image tests, invalid clauses
  When there are images tagged 'de_wiring/sampleimage:latest'
  Then within Config, 'Cmd' should be like 'invalid'
Scenario: Sample image tests, invalid clauses
  When there are images tagged 'de_wiring/sampleimage:latest'
  Then within Config, 'Entrypoint' should not be '["/bin/test", "-c"]'
Scenario: Sample image tests, invalid clauses
  When there are images tagged 'de_wiring/sampleimage:latest'
  Then within Config, 'Entrypoint' should be '["/bin/bash", "-c"]'
