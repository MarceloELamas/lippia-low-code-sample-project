Feature: Eliminar Proyecto

  Background:
    Given header Content-Type = application/json
    And header Accept = */*
    And base url env.base_url_clockify
    And header x-api-key = MDQ2NWMzMDQtMGEwYy00NDA0LWFlYWQtMmVmZTYyM2Y4ZjM4

  @deleteProyect @test
  Scenario: Eliminar proyecto existente
    Given call clockify.feature@updateProyectAux
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProyect}}
    When execute method DELETE
    Then the status code should be 200
    And response should be $.id = {{idProyect}}
    #Este test corre @getWorkspace, @CreateProyectAux,y @UpdateProyectAux

  Scenario: Eliminar proyecto fallido por error HTTP 401
    Given header x-api-key = MDQ2NWMzMDQtMGEwYy00NDA0LWFlYWQtMmVmZTYyM2Y4ZjM4String
    Given call clockify.feature@updateProyectAux
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects/{{idProyect}}
    When execute method DELETE
    Then the status code should be 401
    And response should be $.message = Api key does not exist
    And response should be $.code = 4003

  Scenario: Eliminar proyecto fallido por error HTTP 400
    Given call clockify.feature@GetWorkspaces
    Given endpoint /v1/workspaces/{{idWorkspace}}/projects/6542e434894cb47ead00676a
    When execute method DELETE
    Then the status code should be 400
    And response should be $.message = Cannot delete an active project
    And response should be $.code = 501
