@TP6 @Workspace
Feature: Workspace

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = MDQ2NWMzMDQtMGEwYy00NDA0LWFlYWQtMmVmZTYyM2Y4ZjM4
    Given base url https://api.clockify.me/api
  @test
  Scenario Outline: Crear un workspace
    Given endpoint /v1/workspaces
    And set value <nameWorkspace> of key name in body createWorkspace.json
    When execute method POST
    Then the status code should be 201
    #And response should be $.name = <name>
    #And response should be $.status = <status>
    #And validate schema character.json

    Examples:
      | nameWorkspace       |
      | "MarceloWorkspace2" |