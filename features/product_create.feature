Feature: Product creation
  As a Supervisor
  In order to make new items available as subjects for requests
  I want to be able to add a new product

  Background:
    Given a Supervisor is logged in

  Scenario: Successfully create a Product
    When he creates a new Product
    Then he should not see a "model" input field

  Scenario: Try to create a Product with an already taken model
    Given a Product
    When he creates a new Product with a model already taken
    Then he should see a "model" input field
