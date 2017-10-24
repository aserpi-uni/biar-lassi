Feature: Signing in as a consumer (Facebook fail)
  In order to access the site
  as a Consumer
  I want to sign in with a pre-existing account or Facebook

  @omniauth_test
  Scenario: Try to login with Facebook, manually inserting username and (wrong) password
    Given I created a Consumer account with username "username" and email "email@example.com"
    And I login with Facebook with a null email
    And I fill in "username" (in "form" with "/auth/consumers/facebook/connect_existing" as "action") with "username"
    And I fill in "password" with "wrong_password"
    When I press "Login" in "form" with "/auth/consumers/facebook/connect_existing" as "action"
    Then I should see a "password_sign_in" input field

  @omniauth_test
  Scenario: Try to login with Facebook with an email associated with an Admin account
    # Uses OmniAuth's default email
    Given I created an Admin account with username "username" and email "facebook@example.com"
    When I login with Facebook
    Then I should not see a "username_select" input field

  @omniauth_test
  Scenario: Try to login with Facebook using an username already taken
    Given I created a Consumer account with username "username" and email "email@example.com"
    And I login with Facebook registering the username "username"
    Then I should see a "password_sign_in" input field



    # 1 username&pwd