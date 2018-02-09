Feature: List and show Advice Threads

  Scenario: An Employee from an other Enterprise tries to see the Advice Thread list
    Given an AdviceThread
    And a second Operator is logged in
    When he is on the "AdviceThread main" page
    Then he should see a "authorized" text

  Scenario: An Employee from an other Enterprise tries to see the Product  Thread list
    Given a Product
    And a second Operator is logged in
    When he is on the "Product ProblemThreads" page
    Then he should see a "authorized" text
