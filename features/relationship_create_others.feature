Feature: Relationship creation (as a non-Consumer)
  As a Consumer
  In order to follow a certain Problem Thread or Advice Thread
  I want to be able to create a Relationship

  Scenario: Try to create a Advice Thread Relationship by an Employee
    Given an Employee is logged in
    When he creates a new Advice Thread Relationship
    Then he should not see a button with value "follow"
  Scenario: Try to create a Problem Thread Relationship by an Employee
    Given an Employee is logged in
    When he creates a new Problem Thread Relationship
    Then he should not see a button with value "follow"
  Scenario: Try to create a Advice Thread Relationship when not logged in
    When he creates a new Advice Thread Relationship
    Then he should not see a button with value "follow"
  Scenario: Try to create a Problem Thread Relationship when not logged in
    When he creates a new Advice Thread Relationship
    Then he should not see a button with value "follow"