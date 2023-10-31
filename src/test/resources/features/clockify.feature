@TP6 @Workspace
Feature: Workspace

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And header x-api-key = MDQ2NWMzMDQtMGEwYy00NDA0LWFlYWQtMmVmZTYyM2Y4ZjM4
    Given base url env.base_url_clockify

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


  Scenario: Obtener todos los proyectos por idWorkspace
    Given call clockify.feature@GetWorkspaces
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects
    When execute method GET
    Then the status code should be 200
    And response should be $.[0].id = 653870f6ebc39b75386e105e

  @CreateProyect
  Scenario Outline: Agregar nuevo proyecto a Workspace
    Given call clockify.feature@GetWorkspaces
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects
    And set value "<nameProyect>" of key name in body addProyectWorkspace.json
    When execute method POST
    Then the status code should be 201
    And response should be $.name = <nameProyect>
    * define idProyect = $.id

    Examples:
      | nameProyect |
      | Proyecto16  |


  Scenario: Obtener proyecto existente
    Given call clockify.feature@GetWorkspaces
    Given call clockify.feature@CreateProyect
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProyect}}
    When execute method GET
    Then the status code should be 200
    And response should be $.id = {{idProyect}}


  Scenario: Modificar proyecto existente
    Given call clockify.feature@GetWorkspaces
    Given call clockify.feature@CreateProyect
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProyect}}
    And body updateProyect.json
    When execute method PUT
    Then the status code should be 200
    And response should be $.archived = false






