Feature: Comment an Advice Thread

  Scenario: Try to create a new Advice Thread Comment with a too long content
    Given a Supervisor is logged in
    And an AdviceThread
    When he comments the AdviceThread writing too much
    Then he should see a "error" text

  Scenario: Try to create a new Advice Thread Comment when not logged in
    Given an AdviceThread
    When he is on the "new AdviceThread Comment" page
    Then he should see a "authorized" text

  Scenario: Try to comment an own AdviceThread
    Given a Consumer is logged in
    And an AdviceThread
    When he is on the "new AdviceThread Comment" page
    Then he should see a "authorized" text

  Scenario: Try to comment an AdviceThread two times
    Given an AdviceThread
    And a Consumer is logged in
    And he comments the AdviceThread
    When he is on the "new AdviceThread Comment" page
    Then he should see a "authorized" text
