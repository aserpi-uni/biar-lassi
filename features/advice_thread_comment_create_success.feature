Feature: Comment an Advice Thread

  Background:
    Given an AdviceThread

  Scenario: Successfully create a new Advice Thread Comment by Employee
    Given a Supervisor is logged in
    When he comments the AdviceThread
    Then he should not see a "error" text

  Scenario: Successfully create a new Advice Thread Comment by Consumer
    Given a Consumer is logged in
    When he comments the AdviceThread
    Then he should not see a "Comment" button
