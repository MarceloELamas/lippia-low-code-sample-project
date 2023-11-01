Feature: Obtener Proyectos en Workspace

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And base url env.base_url_clockify
    And header x-api-key = MDQ2NWMzMDQtMGEwYy00NDA0LWFlYWQtMmVmZTYyM2Y4ZjM4

  @getAllProyects
  Scenario: Obtener todos los proyectos por idWorkspace
    Given call clockify.feature@GetWorkspaces
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects
    When execute method GET
    Then the status code should be 200
    And response should be $.[0].id = 654054e74554c542e79c36e6

  Scenario: Obtener todos los proyectos fallido error HTTP 401
    Given header x-api-key = MDQ2NWMzMDQtMGEwYy00NDA0LWFlYWQtMmVmZTYyM2Y4ZjM4String
    Given call clockify.feature@GetWorkspaces
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects
    When execute method GET
    Then the status code should be 401
    And response should be $.message = Api key does not exist
    And response should be $.code = 4003

  Scenario: Obtener todos los proyectos fallido por error HTTP 400
    Given call clockify.feature@GetWorkspaces
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects
    When execute method POST
    Then the status code should be 400
    And response should be $.code = 3002