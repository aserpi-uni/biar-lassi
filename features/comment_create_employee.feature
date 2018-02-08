Feature: Employee Comment creation
  As a Employee
  In order to answer to an assigned problem thread or an advice thread
  I want to be able to create a new comment


  Background:
    Given a Employee is logged in

  Scenario: Successfully create a new Problem Thread Comment by Employee
    When he creates a new ProblemThreadCommentC
    Then he should not see a "content" input field

  Scenario: Try to create a new Problem Thread Comment with a too long content
    Given a ProblemThreadCommentC
    When he creates a new ProblemThreadCommentC with a too long content
    Then he should see a "content" input field

  Scenario: Successfully create a new Advice Thread Comment by Employee
    When he creates a new ProblemThreadCommentC
    Then he should not see a "content" input field

  Scenario: Try to create a new Advice Thread Comment with a too long content
    Given a ProblemThreadCommentC
    When he creates a new ProblemThreadCommentC with a too long content
    Then he should see a "content" input field