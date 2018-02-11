Feature: List and show Problem Threads

  Scenario: An Employee from an other Enterprise tries to see the Advice Thread list
    Given a ProblemThread
    And a second Operator is logged in
    When he is on the "ProblemThread main" page
    Then he should see a "authorized" text

  Scenario: An Employee from an other Enterprise tries to see the Product  Thread list
    Given a Product
    And a second Operator is logged in
    When he is on the "Product ProblemThreads" page
    Then he should see a "authorized" text
