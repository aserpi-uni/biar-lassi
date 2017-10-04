Feature: Signing in as a consumer (Facebook success)
  In order to access the site
  as a Consumer
  I want to sign in with a pre-existing account or Facebook

  @omniauth_test
  Scenario: Login with Facebook and a pre-existing account
    Given I created a Consumer account with username "username" and email "facebook@example.com"
    # OmniAuth has a default configuration
    When I login with Facebook
    Then I should see a "sign_out" link

  @omniauth_test
  Scenario: Create, sign out and login with a Facebook account
    Given I login with Facebook registering the username "facebook"
    And I click on the "sign_out" link
    And I login with Facebook
    Then I should see a "sign_out" link

  @omniauth_test
  Scenario: Login with Facebook and a pre-existing account inserting manually username and password
    Given I created a Consumer account with username "facebook_success" and email "facebook@example.com"
    And I login with Facebook with a null email
    And I fill in "username" (in "form" with "/consumers/facebook/connect_existing" as "action") with "facebook_success"
    And I fill in "password" with "password"
    When I press "Login" in "form" with "/consumers/facebook/connect_existing" as "action"
    Then I should see a "sign_out" link

  @omniauth_test
  Scenario: Login with Facebook creating a new account (email inserted manually)
    Given I login with Facebook with a null email
    When I login with Facebook registering the username "username" and the email "facebook@example.com"
    Then I should see a "/consumers/auth/facebook" link

  @omniauth_test
  Scenario: Login with Facebook creating a new account with no email
    Given I login with Facebook with a null email registering the username "facebook"
    Then I should see a "sign_out" link
    And I should not see a "facebook/disconnect" link
