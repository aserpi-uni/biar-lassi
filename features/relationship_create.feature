Feature: Relationship creation
  As a Consumer
  In order to follow a certain Problem Thread or Advice Thread
  I want to be able to create a Relationship

  Background:
    Given a Consumer is logged in

  Scenario: Successfully create a new Problem Thread Relationship
    Given he creates a new Problem Thread
    When he unfollows
    Then he should see a "Follow" button

  Scenario: Successfully create a new Advice Thread Relationship
    When he creates a new Advice Thread
    When he unfollows
    Then he should see a "Follow" button
