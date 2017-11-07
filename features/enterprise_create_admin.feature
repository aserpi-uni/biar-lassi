Feature: Enterprise creation (as an Admin)
  As an Admin
  In order to add an Enterprise in the framework
  I want to be able to create a new Enterprise resource and a related Supervisor employee.


  Background:
    Given an Admin is logged in

  Scenario: Successfully create an Enterprise
    When he creates a new Enterprise
    Then he should not see a "name" input field

  Scenario: Try to create an Enterprise with an already taken name
    Given an Enterprise
    When the Admin creates a new Enterprise with a name already taken
    Then he should see a "name" input field


  Scenario: Try to create an Enterprise with an already taken username suffix
    Given an Enterprise
    When the Admin creates a new Enterprise with a username suffix already taken
    Then he should see a "name" input field
