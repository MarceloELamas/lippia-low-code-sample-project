Feature: Actualizar proyecto

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And base url env.base_url_clockify
    And header x-api-key = MDQ2NWMzMDQtMGEwYy00NDA0LWFlYWQtMmVmZTYyM2Y4ZjM4

  @updateProyect
  Scenario Outline: Modificar proyecto existente
    Given call clockify.feature@GetWorkspaces
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects/<idProyect>
    And body updateProyect.json
    When execute method PUT
    Then the status code should be 200
    And response should be $.archived = true

    Examples:
      | idProyect                |
      | 653870f6ebc39b75386e105e |

  Scenario: Modificar proyecto fallido por error HTTP 401
    Given header x-api-key = MDQ2NWMzMDQtMGEwYy00NDA0LWFlYWQtMmVmZTYyM2Y4ZjM4String
    Given call clockify.feature@GetWorkspaces
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects/653870f6ebc39b75386e105e
    And body updateProyect.json
    When execute method PUT
    Then the status code should be 401
    And response should be $.message = Api key does not exist
    And response should be $.code = 4003

  Scenario: Modificar proyecto fallido por error HTTP 400
    Given call clockify.feature@GetWorkspaces
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects/653870f6ebc39b75386e105e
    And set value "Hola" of key archived in body updateProyect.json
    When execute method PUT
    Then the status code should be 400
    And response should be $.code = 3002



