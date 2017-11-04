Feature: Delete an user

  Scenario: Delete a consumer account
    Given I created a Consumer account with username "username" and email "example@example.com"
    And I login as an Consumer with username "username"
    And I am on the "Consumer settings" page
    And I press "Delete"
    When I press "Confirm"
    Then I should see a "deleted" text