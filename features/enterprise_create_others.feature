Feature: Enterprise creation (as a non-Admin)
  As an Admin
  In order to add an Enterprise in the framework
  I want to be able to create a new Enterprise resource and a related Supervisor employee.

  Scenario: Try to create an Enterprise as a Consumer
    Given a Consumer is logged in
    When he is on the "new Enterprise" page
    Then he should not see a "name" input field

  Scenario: Try to create an Enterprise as an Employee
    Given an Employee is logged in
    When he is on the "new Enterprise" page
    Then he should not see a "name" input field

  Scenario: Try to create an Enterprise when not logged in
    When he is on the "new Enterprise" page
    Then he should not see a "name" input field
