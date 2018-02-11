Feature: Showing an Enterprise

  Scenario: Supervisor sees his Enterprise
    Given a Supervisor is logged in
    When he is on the Enterprise's main page
    Then he should see a "Enterprise_one" text

  Scenario: An Employee from an other Enterprise tries to see an Enterprise
    Given an Enterprise
    And a second Operator is logged in
    When he is on the Enterprise's main page
    Then he should not see a "Enterprise_one" text

  Scenario: An Employee from an other Enterprise tries to see the product page
    Given an Enterprise
    And a second Operator is logged in
    When he is on the Enterprise's products page
    Then he should see a "authorized" text
