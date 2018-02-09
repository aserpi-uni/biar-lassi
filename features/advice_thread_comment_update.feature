Feature: Update an Advice Thread Comment

  Scenario: Consumer updates a comment
    Given a Consumer is logged in
    And an AdviceThread Comment created by a Consumer
    And he is on the "edit Comment" page
    And he changes the "content" field to "New Comment content"
    When he saves
    Then he should not see a "error" text

  Scenario: Admin incorrectly changes a Comment created by a Consumer
    Given an AdviceThread Comment created by an Consumer
    And an Admin is logged in
    And he is on the "edit Comment" page
    And he changes the "content" field to "New"
    When he saves
    Then he should see a "error" text
