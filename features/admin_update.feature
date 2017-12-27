Feature: Update an admin

  Background:
    Given an Admin is logged in

  Scenario: Change the email address
    Given he is on his settings page
    And he changes the "email" field to "admin_email_two@example.com"
    When he saves
    Then he should see a "email" input field with value "admin_email_two@example.com"

  Scenario: Lock an account
    Given he locks his account
    When the Admin logs in
    Then he should see a "locked" text

  Scenario: Lock and unlock another Admin account
    Given a second Admin has an account
    And he locks the second Admin account
    When he unlocks the second Admin account
    Then he should see a "unlocked" text

  Scenario: Delete the account
    Given he deletes his account
    When the Admin logs in
    Then he should see a "locked" text

  Scenario: Delete another Admin account
    Given a second Admin has an account
    And he deletes the second Admin account
    Then he should see a "deleted" text
