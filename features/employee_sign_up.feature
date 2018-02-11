Feature: Employee creation
  As a Supervisor (or Admin)
  In order to accept a new employee in my organization (or create a new Enterprise)
  I want to register a new employee account.

  Scenario: Admin creates a Supervisor
    Given an Admin is logged in
    And an Enterprise
    When he creates a new Employee
    Then he should not see a "username" input field

  Scenario: Admin tries to create an Operator with a nonexistent Enterprise
    Given an Admin is logged in
    When he creates a new Employee with a nonexistent Enterprise
    Then he should see a "username" input field

  Scenario: Supervisor creates an Operator
    Given a Supervisor is logged in
    When he creates a new Operator
    Then he should not see a "username" input field

  Scenario: Operator tries to create an Employee
    Given an Operator is logged in
    When he is on the "new Employee" page
    Then he should not see a "username" input field

  Scenario: Admin tries to create an Employee with an already taken username
    Given an Employee has an account
    And an Admin is logged in
    When he creates a new Employee with a username already taken
    Then he should see a "username" input field
