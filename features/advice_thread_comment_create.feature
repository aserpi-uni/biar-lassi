Feature: Comment an Advice Thread

  Background:
    Given an AdviceThread

  Scenario: Successfully create a new Advice Thread Comment by Employee
    Given a Supervisor is logged in
    When he comments the AdviceThread
    Then he should not see a "error" text

  Scenario: Try to create a new Advice Thread Comment with a too long content
    Given a Supervisor is logged in
    When he comments the AdviceThread writing too much
    Then he should see a "error" text

  Scenario: Try to create a new Advice Thread Comment when not logged in
    When he is on the "new AdviceThread Comment" page
    Then he should see a "authorized" text

  Scenario: Successfully create a new Advice Thread Comment by Consumer
    Given a Consumer is logged in
    When he comments the AdviceThread
    Then he should see a "AdviceThread Comment" text
