Feature: Problem Thread creation
  As a Consumer
  In order to solve a problem regarding a certain product
  I want to be able to create a new problem thread

  Background:
    Given a Consumer is logged in

  Scenario: Successfully create a new ProblemThread
    When he creates a new Problem Thread
    Then he should not see a "title" input field

  Scenario: Try to create a new Problem Thread with a too long content
    Given a ProblemThread
    When he creates a new Problem Thread with a too long content
    Then he should see a "content" input field

  Scenario: Try to create a new Problem Thread with a too long title
    Given a ProblemThread
    When he creates a new Problem Thread with a too long title
    Then he should see a "title" input field

  Scenario: Try to create a new Problem Thread by Employee
    Given an Employee is logged in
    When he creates a new Problem Thread
    Then he should see a " You're not allowed to make this action" text