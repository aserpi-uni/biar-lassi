Feature: Update a Problem Thread Comment
  As an Employee
  In order to modify a comment of a problem thread
  I want to be able to update a Comment

  Background:
    Given a Employee is logged in
    And a ProblemThreadCommentE
    And he is on the ProblemThreadCommentE's settings page

  Scenario: Consumer updates a comment
    Given he changes the "content" field to "Problem thread comment content by employee_two"
    When he saves
    Then he should see a "content" input field with value "Problem thread comment content by employee_two"