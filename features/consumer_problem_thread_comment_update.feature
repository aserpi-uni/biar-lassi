Feature: Update a Problem Thread Comment
  As a Consumer
  In order to modify a comment of a problem thread
  I want to be able to update a Comment

  Background:
    Given a Consumer is logged in
    And a ProblemThreadCommentC
    And he is on the ProblemThreadCommentC's settings page

  Scenario: Consumer updates a comment
    Given he changes the "content" field to "Problem thread comment content by consumer_two"
    When he saves
    Then he should see a "content" input field with value "Problem thread comment content by consumer_two"