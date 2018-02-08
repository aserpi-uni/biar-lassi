Feature: Update a Problem Thread
  As a Consumer
  In order to modify the title or the content of a problem thread
  I want to be able to update a Problem Thread

  Background:
    Given a Consumer is logged in
    And a ProblemThread
    And he is on the ProblemThread's settings page

  Scenario: Consumer updates a Problem Thread
    Given he changes the "title" field to "Problem Thread Title_two"
    When he saves
    Then he should see a "title" input field with value "Problem Thread Title_two"
