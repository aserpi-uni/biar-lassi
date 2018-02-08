Feature: Advice Thread creation (as a non-Consumer)
  As a Consumer
  In order to suggest advices regarding a certain product
  I want to be able to create a new problem thread

  Scenario: Try to create a new Advice Thread by Employee
    Given an Employee is logged in
    When he creates a new Advice Thread
    Then he should not see a "title" input field

  Scenario: Try to create a new Advice Thread when not logged in
    When he creates a new Advice Thread
    Then he should not see a "title" input field