Feature: Obtener Proyecto

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And base url env.base_url_clockify
    And header x-api-key = MDQ2NWMzMDQtMGEwYy00NDA0LWFlYWQtMmVmZTYyM2Y4ZjM4

  @getProyect
  Scenario Outline: Obtener proyecto existente
    Given call clockify.feature@GetWorkspaces
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects/<idProyect>
    When execute method GET
    Then the status code should be 200
    And response should be $.id = <idProyect>

    Examples:
      | idProyect                |
      | 653870f6ebc39b75386e105e |

  Scenario: Obtener proyecto fallido por error HTTP 401
    Given header x-api-key = MDQ2NWMzMDQtMGEwYy00NDA0LWFlYWQtMmVmZTYyM2Y4ZjM4String
    Given call clockify.feature@GetWorkspaces
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects/653870f6ebc39b75386e105e
    When execute method GET
    Then the status code should be 401
    And response should be $.message = Api key does not exist
    And response should be $.code = 4003

  Scenario: Obtener proyecto fallido por error HTTP 400
    Given call clockify.feature@GetWorkspaces
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects/653870f6ebc39b75386e105
    When execute method GET
    Then the status code should be 400
    And response should be $.code = 501
    And response should be $.message = PROJECT with id 653870f6ebc39b75386e105 doesn't belong to WORKSPACE with id 65386fe31a76042b2285bf81
