Feature: Update a Product

  Background:
    Given a Supervisor is logged in
    And a Product
    And he is on the Product's settings page

  Scenario: Supervisor updates a Product
    Given he changes the "model" field to "Model_two"
    When he saves
    Then he should see a "model" input field with value "Model_two"

  Scenario: Supervisor tries to update a Product with a model already taken
    Given a second Product
    And he changes the "model" field to "Model_two"
    When he saves
    Then he should see a "Model already used" text
