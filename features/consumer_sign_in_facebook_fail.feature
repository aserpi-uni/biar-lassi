Feature: Signing in as a consumer (Facebook fail)
  In order to access the site
  as a Consumer
  I want to sign in with a pre-existing account or Facebook

  @omniauth_test
  Scenario: Try to login with Facebook, manually inserting username and (wrong) password
    Given a Consumer has a confirmed account
    And a Consumer logs in with Facebook with no email
    When he connects to a pre-existent account with incorrect credentials
    Then he should see a "username_select" input field

  @omniauth_test
  Scenario: Try to login with Facebook with an email associated with an Admin account
    # Uses OmniAuth's default email
    Given an Admin account with the same email as a Facebook one
    When he logs in with Facebook
    Then he should not see a "username_select" input field

  @omniauth_test
  Scenario: Try to login with Facebook using an username already taken
    When a Consumer logs in with Facebook choosing a taken username
    Then he should see a "password_sign_in" input field
