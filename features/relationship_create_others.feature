Feature: Relationship creation (as a non-Consumer)
  As a Consumer
  In order to follow a certain Problem Thread or Advice Thread
  I want to be able to create a Relationship

  Scenario: Try to create a Advice Thread Relationship by an Employee
    Given an Employee is logged in
    And a ProblemThread
    When he is on the "ProblemThread main" page
    Then he should not see a "Follow" button

  Scenario: Try to create a Problem Thread Relationship by an Employee
    Given an Employee is logged in
    And a ProblemThread
    When he is on the "ProblemThread main" page
    Then he should not see a "Follow" button

  Scenario: Try to create a Advice Thread Relationship when not logged in
    Given an AdviceThread
    When he is on the "AdviceThread main" page
    Then he should not see a "Follow" button

  Scenario: Try to create a Problem Thread Relationship when not logged in
    Given an AdviceThread
    When he is on the "AdviceThread main" page
    Then he should not see a "Follow" button
