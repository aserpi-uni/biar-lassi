Feature: Signing in as a consumer
  In order to access the site
  as a Consumer
  I want to sign in with a pre-existing account or Facebook

  Background:
    Given I am on the "Consumer sign in" page

  Scenario: Log in with a pre-existing account
    Given I created a Consumer account with username "consumer_sign_in_success" and email "consumer_sign_in_success@example.com"
    And I fill in "consumer_username" with "consumer_sign_in_success"
    And I fill in "consumer_password" with "password"
    When I press "Login"
    Then I should see a "sign_out" link

  Scenario: Try to log in with a nonexistent account
    Given I fill in "consumer_username" with "nonexistent"
    And I fill in "consumer_password" with "password"
    When I press "Login"
    Then I should see a "consumer_username" input field

  Scenario: Try to log in with a wrong password
    Given I created a Consumer account with username "consumer_sign_in_fail" and email "consumer_sign_in_fail@example.com"
    And I fill in "consumer_username" with "consumer_login_fail"
    And I fill in "consumer_password" with "wrong_password"
    When I press "Login"
    Then I should see a "consumer_username" input field
