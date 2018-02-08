Feature: Showing a product

  Scenario: Supervisor sees a Product from his Enterprise
    Given a Supervisor is logged in
    And a Product
    When he is on the Product's main page
    Then he should see a "Enterprise_one Model" text

  Scenario: An Employee from an other Enterprise tries to see a Product
    Given a Product
    And a second Operator is logged in
    When he is on the Product's main page
    Then he should not see a "Enterprise_one Model" text
