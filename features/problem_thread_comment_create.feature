Feature: Comment a Problem Thread

  Background:
    Given a ProblemThread

  Scenario: Successfully create a new Problem Thread Comment by referent
    Given the referent is logged in
    When he comments the ProblemThread
    Then he should not see a "error" text

  Scenario: Referent tries to create a new Problem Thread Comment with a too long content
    Given the referent is logged in
    When he comments the ProblemThread writing too much
    Then he should see a "error" text

  Scenario: Try to create a new Problem Thread Comment by Supervisor
    Given a Supervisor is logged in
    When he is on the "new ProblemThread Comment" page
    Then he should see a "authorized" text

  Scenario: Try to create a new Problem Thread Comment when not logged in
    When he is on the "new ProblemThread Comment" page
    Then he should see a "authorized" text

  Scenario: Successfully create a new Problem Thread Comment by Consumer
    Given a Consumer is logged in
    When he comments the ProblemThread
    Then he should not see a "error" text
