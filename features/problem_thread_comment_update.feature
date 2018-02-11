Feature: Update a Problem Thread Comment

  Scenario: Operator updates a comment
    Given a ProblemThread Comment created by an Operator
    And the referent is logged in
    And he is on the "edit Comment" page
    And he changes the "content" field to "New Comment content"
    When he saves
    Then he should not see a "error" text

  Scenario: Admin incorrectly changes a Comment created by a Consumer
    Given an ProblemThread Comment created by an Consumer
    And an Admin is logged in
    And he is on the "edit Comment" page
    And he changes the "content" field to "New"
    When he saves
    Then he should see a "error" text

  Scenario: Consumer marks
    Given a Consumer is logged in
    And a ProblemThread Comment created by an Operator
    And he marks the Comment as a solution
    When he unmarks the Comment as a solution
    Then he should see a "Mark as solution" button
