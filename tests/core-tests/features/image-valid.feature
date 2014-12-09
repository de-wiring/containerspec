# This file describes valid scenarios based upon
# the docker hub image of debian:jessie and scratch:latest

@Valid
Feature: Valid clauses work

@Registry
Scenario: valid images can be found
  Given i pull 'debian:jessie'
  Given i pull 'scratch:latest'

Scenario: When Clauses work
  When there are images

Scenario: When Clauses work
  When there are images with repo 'debian'

Scenario: When Clauses work
  When there are images with tags like 'jessie'

Scenario: When Clauses work
  When there are images with tags like 'ian:jess'

Scenario: When Clauses work
  When there are images tagged 'debian:jessie'

Scenario: When Clauses work
  When there are images tagged 'scratch:latest'

Scenario: Inspect, valid 1st level clauses work
  When there are images tagged 'debian:jessie'
  Then 'Os' should be 'linux'
  Then 'Os' should not be 'nonexisting'
  Then 'Size' should be '0'
  Then 'Size' should not be '1'
  Then 'Architecture' should be 'amd64'
  Then 'Architecture' should not be '6502'
  Then 'Architecture' should be like '.*64.*'
  Then 'Architecture' should not be like '.*16.*'

Scenario: Inspect, valid 1st level clauses work
  When there are images tagged 'debian:jessie'
  Then 'Architecture' should be set
  Then 'Os' should be set
  Then 'Comment' should not be set

Scenario: Inspect Container Config, valid 2nd level clauses work
  When there are images tagged 'debian:jessie'
  Then within Config, 'AttachStdin' should be 'false'
  Then within Config, 'AttachStdin' should be like 'false'
  Then within Config, 'AttachStdin' should not be 'true'
  Then within Config, 'AttachStdin' should not be like 'true'
  Then within Config, 'AttachStdin' should not be like '^$'
  Then within Config, 'Env' should be like '.*/bin.*'
  Then within Config, 'Env' should not be like '.*/opt.*'
  Then within Config, 'Entrypoint' should not be set
  Then within Config, 'Hostname' should be set
