Feature: Edit an admin

  Background:
    Given I created an Admin account with username "username" and email "admin@example.com"
    And I login as an Admin with username "username@admin"

  Scenario: Chenge the email address
    Given I am on the "edit" page for Admin "username@admin"
    And I fill in "email" with "admin2@example.com"
    When I press "Save"
    Then I should see a "email" input field with value "admin2@example.com"

  Scenario: Lock and an account
    Given I am on the "edit" page for Admin "username@admin"
    And I press "Lock"
    When I login as an Admin with username "username@admin"
    Then I should see a "locked" text

  Scenario: Lock and unlock another Admin account
    Given I created an Admin account with username "username2" and email "admin2@example.com"
    And I am on the "edit" page for Admin "username2@admin"
    And I press "Lock"
    When I press "Unlock"
    Then I should see a "unlocked" text

  Scenario: Delete the account
    And I am on the "edit" page for Admin "username@admin"
    And I press "Delete"
    When I press "Confirm"
    Then I should see a "deleted" text

  Scenario: Delete another Admin account
    Given I created an Admin account with username "username2" and email "admin2@example.com"
    And I am on the "edit" page for Admin "username2@admin"
    And I press "Delete"
    When I press "Confirm"
    Then I should see a "deleted" text
