Feature: Signing up as a consumer
  In order to access the site
  as a Consumer
  I want to create a new account

  Scenario: Create a new account with success
    When I accurately register a Consumer with username "consumer_sign_up_success" and email "consumer_sign_up_fail@example.com"
    Then I should see a "Welcome" text

  Scenario: Try to create a new account with a password too short
    Given I am on the "Consumer sign up" page
    And I fill in "consumer_username" with "consumer_sign_up_success"
    And I fill in "consumer_email" with "consumer_sign_up_success@example.com"
    And I fill in "consumer_password" with "pwd"
    And I fill in "consumer_password_confirmation" with "pwd"
    When I press "Register"
    Then I should see a "consumer_username" input field

  Scenario: Try to create a new account with a wrong password confirmation
    Given I am on the "Consumer sign up" page
    And I fill in "consumer_username" with "consumer_sign_up_success"
    And I fill in "consumer_email" with "consumer_sign_up_success@example.com"
    And I fill in "consumer_password" with "password"
    And I fill in "consumer_password_confirmation" with "wrong_password"
    When I press "Register"
    Then I should see a "consumer_username" input field

  Scenario: Try to create a new account with an username already taken
    Given I created a Consumer account with username "consumer_sign_up_fail" and email "consumer_sign_up_fail@example.com"
    When I accurately register a Consumer with username "consumer_sign_up_fail" and email "consumer@example.com"
    Then I should see a "consumer_username" input field

  Scenario: Try to create a new account with an incorrect username
    When I accurately register a Consumer with username "fail@consumer" and email "consumer_sign_up_fails@example.com"
    Then I should see a "consumer_username" input field

  Scenario: Try to create a new account with an email already taken
    Given I created an Admin account with username "test@admin" and email "consumer_sign_up_fail@example.com"
    When I accurately register a Consumer with username "consumer_sign_up_fail" and email "consumer_sign_up_fail@example.com"
    Then I should see a "consumer_username" input field
