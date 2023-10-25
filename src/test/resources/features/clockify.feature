@TP6 @Workspace
Feature: Workspace

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = MDQ2NWMzMDQtMGEwYy00NDA0LWFlYWQtMmVmZTYyM2Y4ZjM4
    Given base url https://api.clockify.me/api

  Scenario Outline: Crear un workspace
    Given endpoint /v1/workspaces
    And set value <nameWorkspace> of key name in body createWorkspace.json
    When execute method POST
    Then the status code should be 201

    Examples:
      | nameWorkspace       |
      | "MarceloWorkspace3" |

  @GetWorkspaces
  Scenario: Obtener todos los workspaces
    Given endpoint /v1/workspaces
    When execute method GET
    Then the status code should be 200
    * define idWorkspace = $.[5].id

  @test
  Scenario: Obtener todos los proyectos por idWorkspace
    Given call clockify.feature@GetWorkspaces
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects
    When execute method GET
    Then the status code should be 200
    And response should be $.[0].id = 653870f6ebc39b75386e105e