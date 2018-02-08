Feature: Update an Advice Thread
  As a Consumer
  In order to modify the title or the content of an Advice thread
  I want to be able to update a Advice Thread

  Background:
    Given a Consumer is logged in
    And a AdviceThread
    And he is on the AdviceThread's settings page

  Scenario: Consumer updates a Problem Thread
    Given he changes the "title" field to "Advice Thread Title_two"
    When he saves
    Then he should see a "title" input field with value "Advice Thread Title_two"