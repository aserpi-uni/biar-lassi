Feature: Signing in as a consumer
  In order to access the site
  as a Consumer
  I want to sign in with a pre-existing account or Facebook

  Scenario: Log in with a pre-existing account
    Given I created a Consumer account with username "consumer_sign_in_success" and email "consumer_sign_in_success@example.com"
    When I accurately login as a Consumer with username "consumer_sign_in_success"
    Then I should see a "sign_out" link

  Scenario: Try to log in with a nonexistent account
    When I accurately login as a Consumer with username "nonexistent"
    Then I should see a "consumer_username" input field

  Scenario: Try to log in with a wrong password
    Given I created a Consumer account with username "consumer_sign_in_fail" and email "consumer_sign_in_fail@example.com"
    And I am on the "Consumer sign in" page
    And I fill in "consumer_username" with "consumer_login_fail"
    And I fill in "consumer_password" with "wrong_password"
    When I press "Login"
    Then I should see a "consumer_username" input field

  @omniauth_test
  Scenario: Login with Facebook and a pre-existing account
    Given I created a Consumer account with username "facebook_success" and email "facebook@example.com"
    And I am on the "Consumer sign in" page
    When I click on the "/consumers/auth/facebook" link
    Then I should see a "sign_out" link

  @omniauth_test
  Scenario: Login with Facebook creating a new account
    Given I am on the "Consumer sign in" page
    And I want to login with Facebook with "" as email
    And I click on the "/consumers/auth/facebook" link
    And I fill in "username" (in "form" with "action" as "/consumers/facebook/select_username") with "facebook_success"
    And I fill in "email" with "facebook@example.com"
    When I press "Register" in "form" with "action" as "/consumers/facebook/select_username"
    Then I should see a "sign_out" link

  # TODO: Scenario: Try to login with Facebook, inserting manually an email and a wrong password

  # TODO: Scenario: Try to login with Facebook associated with an Employee account

  # TODO: Scenario: Try to login with Facebook creating a new account with an username already taken by an Admin
