Feature: Employee creation
  As a Supervisor (or Admin)
  In order to accept a new employee in my organization (or create a new Enterprise)
  I want to register a new employee account.

  Scenario: Admin creates a Supervisor
    Given I created an Admin account with username "admin" and email "admin@example.com"
    And I login as an Admin with username "admin"
    And I created an Enterprise with name "enterprise" and username suffix "user_suffix"
    When I register an Employee account with username "employee", email "employee@example.com", role "Supervisor" and enterprise "enterprise"
    Then I should see a "employee@user_suffix" title

  Scenario: Admin tries to create an Operator with a nonexistent Enterprise
    Given I created an Admin account with username "admin" and email "admin@example.com"
    And I login as an Admin with username "admin"
    When I register an Employee account with username "employee", email "employee@example.com", role "Supervisor" and enterprise "enterprise"
    Then I should see a "username" input field

  Scenario: Supervisor creates an Operator
    Given I created an Enterprise with name "enterprise" and username suffix "user_suffix"
    And I created an Employee account with username "employee", email "supervisor@example.com", role "supervisor" and enterprise "enterprise"
    And I login as an Employee with username "employee@user_suffix"
    When I register an Employee account with username "operator", email "operator@example.com", role "Operator"
    Then I should see a "operator@user_suffix" title

  Scenario: Operator tries to create an Employee
    Given I created an Enterprise with name "enterprise" and username suffix "user_suffix"
    And I created an Employee account with username "employee", email "employee@example.com", role "operator" and enterprise "enterprise"
    And I login as an Employee with username "employee@user_suffix"
    When I am on the "new Employee" page
    Then I should not see a "username" input field

  Scenario: Admin tries to create an Employee with an already taken username
    Given I created an Admin account with username "admin" and email "admin@example.com"
    And I created an Enterprise with name "enterprise" and username suffix "nick_suffix"
    And I login as an Admin with username "admin"
    And I created an Employee account with username "employee", email "supervisor@example.com", role "supervisor" and enterprise "enterprise"
    And I register an Employee account with username "employee", email "supervisor@example.com", role "Supervisor" and enterprise "enterprise"
    Then I should see a "username" input field
