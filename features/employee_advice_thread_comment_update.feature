Feature: Update an Advice Thread Comment
  As an Employee
  In order to modify a comment of a problem thread
  I want to be able to update a Comment

  Background:
    Given a Employee is logged in
    And a AdviceThreadCommentE
    And he is on the AdviceThreadCommentE's settings page

  Scenario: Consumer updates a comment
    Given he changes the "content" field to "Advice thread comment content by employee_two"
    When he saves
    Then he should see a "content" input field with value "Advice thread comment content by employee_two"