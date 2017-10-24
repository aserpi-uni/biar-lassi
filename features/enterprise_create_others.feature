Feature: Enterprise creation (as a non-Admin)
  As an Admin
  In order to add an Enterprise in the framework
  I want to be able to create a new Enterprise resource and a related Supervisor employee.

  Scenario: Try to create an Enterprise as a Consumer
    Given I created a Consumer account with username "username" and email "consumer@example.com"
    And I login as a Consumer with username "username"
    When I am on the "new Enterprise" page
    Then I should not see a "name" input field

  Scenario: Try to create an Enterprise when not logged in
    When I am on the "new Enterprise" page
    Then I should not see a "name" input field
