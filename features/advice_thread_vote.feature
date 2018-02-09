Feature: Comment an AdviceThread
  As a User
  In order to express my opinion
  I want to be able to comment a thread

  Scenario: Successfully downvote a ProblemThread
    Given a ProblemThread
    And a Consumer is logged in
    When he downvotes the ProblemThread
    Then he should see a "-1" text

  Scenario: See all downvotes for a ProblemThread
    Given a ProblemThread
    And a second Operator is logged in
    When he is on the "ProblemThread Downvotes" page
    Then he should see a "authorized" text

  Scenario: Try to downvote an own Comment
    Given a Consumer is logged in
    And a ProblemThread Comment created by a Consumer
    When he is on the "new Comment Downvote" page
    Then he should see a "authorized" text
