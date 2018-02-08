Feature: Advice Thread creation
  As a Consumer
  In order to suggest advices regarding a certain product
  I want to be able to create a new problem thread

  Background:
    Given a Consumer is logged in

  Scenario: Successfully create a new AdviceThread
    When he creates a new Advice Thread
    Then he should not see a "title" input field
    And he should not see a "content" input field

  Scenario: Try to create a new Advice Thread with a too long content
    Given an AdviceThread
    When he creates a new Advice Thread with a too long content
    Then he should see a "content" input field

  Scenario: Try to create a new Problem Thread with a too long title
    Given an AdviceThread
    When he creates a new Advice Thread with a too long title
    Then he should see a "title" input field