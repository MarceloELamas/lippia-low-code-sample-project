Feature: Crear Proyecto

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And base url env.base_url_clockify
    And header x-api-key = MDQ2NWMzMDQtMGEwYy00NDA0LWFlYWQtMmVmZTYyM2Y4ZjM4


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
      | Proyecto19  |

  Scenario: Agregar nuevo proyecto fallido por error HTTP 401
    Given header x-api-key = MDQ2NWMzMDQtMGEwYy00NDA0LWFlYWQtMmVmZTYyM2Y4ZjM4String
    Given call clockify.feature@GetWorkspaces
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects
    And set value "Proyecto19" of key name in body addProyectWorkspace.json
    When execute method POST
    Then the status code should be 401
    And response should be $.message = Api key does not exist
    And response should be $.code = 4003

  Scenario: Agregar nuevo proyecto fallido por error HTTP 400
    Given call clockify.feature@GetWorkspaces
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects
    And set value "Proyecto4" of key name in body addProyectWorkspace.json
    When execute method POST
    Then the status code should be 400
    And response should be $.message = Proyecto4 project for client  already exists.
    And response should be $.code = 501
