# This file describes valid scenarios based upon
# the docker hub image of debian:jessie and scratch:latest

@Valid
Feature: Valid clauses work

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
  Then 'Architecture' should be 'amd64'
  Then 'Architecture' should not be '6502'
  Then 'Architecture' should be like '.*64.*'
  Then 'Architecture' should not be like '.*16.*'

Scenario: Inspect, valid 1st level clauses work
  When there are images tagged 'debian:jessie'
  Then 'Architecture' should be set
  Then 'Os' should be set
  Then 'Comment' should not be set
