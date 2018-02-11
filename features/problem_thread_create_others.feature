Feature: Problem Thread creation (as a non-Consumer)
  As a Consumer
  In order to solve a problem regarding a certain product
  I want to be able to create a new problem thread

  Scenario: Try to create a new Problem Thread by Employee
    Given an Employee is logged in
    And a Product
    When he is on the "new ProblemThread" page
    Then he should not see a "title" input field

  Scenario: Try to create a new Problem Thread when not logged in
    Given a Product
    When he is on the "new ProblemThread" page
    Then he should not see a "title" input field
