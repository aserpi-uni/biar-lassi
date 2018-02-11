Feature: Update an Advice Thread
  As a Consumer
  In order to modify the title or the content of an Advice thread
  I want to be able to update a Advice Thread

  Scenario: Consumer updates an Advice Thread
    Given a Consumer is logged in
    And a AdviceThread
    And he is on the "edit Advice Thread" page
    And he changes the "title" field to "Advice Thread Title_two"
    When he saves
    Then he should see a "Advice Thread Title_two" text

  Scenario: Supervisor changes the status of an Advice Thread
    Given a Supervisor is logged in
    And an AdviceThread
    And he is on the "edit Advice Thread" page
    And he changes the "status" select to "Implemented"
    When he saves
    Then he should see a "Implemented" text
