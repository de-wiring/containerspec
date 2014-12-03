# This file describes invalid conditions
# which do not apply. All scenarios have to fail.

@Invalid
Feature: Invalid clauses do not work

#Scenario: invalid images cannot be found
#  Given i pull 'scratch:stoneage'

Scenario: Invalid When Clauses do not work
  When there are images with repo 'nonexisting'

Scenario: Invalid When Clauses do not work
  When there are images with tags like 'nonex.'

Scenario: Invalid When Clauses do not work
  When there are images with tags like 'non:exist'

Scenario: Invalid When Clauses do not work
  When there are images tagged 'non:exist'

Scenario: Inspect, invalid 1st level clauses do not work
  When there are images tagged 'debian:jessie'
  Then 'Os' should not be 'linux'

Scenario: Inspect, invalid 1st level clauses do not work
  When there are images tagged 'debian:jessie'
  Then 'Os' should be 'nonexisting'

Scenario: Inspect, invalid 1st level clauses do not work
  When there are images tagged 'debian:jessie'
  Then 'Size' should not be '0'

Scenario: Inspect, invalid 1st level clauses do not work
  When there are images tagged 'debian:jessie'
  Then 'Size' should be '1'

Scenario: Inspect, invalid 1st level clauses do not work
  When there are images tagged 'debian:jessie'
  Then 'Architecture' should not be 'amd64'

Scenario: Inspect, invalid 1st level clauses do not work
  When there are images tagged 'debian:jessie'
  Then 'Architecture' should be '6502'

Scenario: Inspect, invalid 1st level clauses do not work
  When there are images tagged 'debian:jessie'
  Then 'Architecture' should not be like '.*64.*'

Scenario: Inspect, invalid 1st level clauses do not work
  When there are images tagged 'debian:jessie'
  Then 'Architecture' should be like '.*16.*'

Scenario: Inspect, invalid 1st level clauses work
  When there are images tagged 'debian:jessie'
  Then 'Architecture' should not be set

Scenario: Inspect, invalid 1st level clauses work
  When there are images tagged 'debian:jessie'
  Then 'Os' should not be set

Scenario: Inspect, invalid 1st level clauses work
  When there are images tagged 'debian:jessie'
  Then 'Comment' should be set

Scenario: Inspect Container Config, invalid 2nd level clauses work
  When there are images tagged 'debian:jessie'
  Then within ContainerConfig, 'AttachStdin' should not be like 'false'

Scenario: Inspect Container Config, invalid 2nd level clauses work
  When there are images tagged 'debian:jessie'
  Then within ContainerConfig, 'AttachStdin' should be like 'true'

Scenario: Inspect Container Config, invalid 2nd level clauses work
  When there are images tagged 'debian:jessie'
  Then within ContainerConfig, 'AttachStdin' should be like '^$'

Scenario: Inspect Container Config, invalid 2nd level clauses work
  When there are images tagged 'debian:jessie'
  Then within ContainerConfig, 'Env' should not be like '.*/bin.*'

Scenario: Inspect Container Config, invalid 2nd level clauses work
  When there are images tagged 'debian:jessie'
  Then within ContainerConfig, 'Env' should be like '.*/opt.*'

Scenario: Inspect Container Config, invalid 2nd level clauses work
  When there are images tagged 'debian:jessie'
  Then within ContainerConfig, 'Entrypoint' should be set

Scenario: Inspect Container Config, invalid 2nd level clauses work
  When there are images tagged 'debian:jessie'
  Then within ContainerConfig, 'Hostname' should not be set

Scenario: Inspect Container Config, invalid 2nd level clauses work
  When there are images tagged 'debian:jessie'
  Then within NonexistingSubpart, 'Whatever' should not be set
