Feature: Update an Advice Thread Comment
  As a Consumer
  In order to modify a comment of a problem thread
  I want to be able to update a Comment

  Background:
    Given a Consumer is logged in
    And a AdviceThreadCommentC
    And he is on the AdviceThreadCommentC's settings page

  Scenario: Consumer updates a comment
    Given he changes the "content" field to "Advice thread comment content by consumer_two"
    When he saves
    Then he should see a "content" input field with value "Advice thread comment content by consumer_two"