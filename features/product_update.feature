Feature: Update a Product

  Background:
    Given a Supervisor is logged in
    And a Product
    And he is on the Product's settings page

  Scenario: Supervisor updates a Product
    Given he changes the "model" field to "Model_two"
    When he saves
    Then he should see a "Model_two" text

  Scenario: Supervisor tries to update a Product with a model already taken
    Given a second Product
    And he changes the "model" field to "Model_two"
    When he saves
    Then he should see a "Model already used" text

  Scenario: Supervisor deletes and restores a product
    And he deletes the Product
    When he restores the Product
    Then he should see a "Delete" text
