Feature: Signing in as a consumer (Facebook success)
  In order to access the site
  as a Consumer
  I want to sign in with a pre-existing account or Facebook

  @omniauth_test
  Scenario: Login with Facebook and a pre-existing account
    Given a Consumer account with the same email as a Facebook one
    # OmniAuth has a default configuration
    When a Consumer logs in with Facebook
    Then he should see a "Consumer sign out" link

  @omniauth_test
  Scenario: Create, sign out and login with a Facebook account
    Given a Consumer logs in with Facebook registering an username
    And he signs out
    When a Consumer logs in with Facebook
    Then he should see a "Consumer sign out" link

  @omniauth_test
  Scenario: Login with Facebook and a pre-existing account inserting manually username and password
    Given a Consumer has a confirmed account
    And he logs in with Facebook
    When he connects to a pre-existent account
    Then he should see a "Consumer sign out" link

  @omniauth_test
  Scenario: Login with Facebook creating a new account (email inserted manually)
    Given a Consumer logs in with Facebook with no email registering an username and an email
    Then he should see a "username" input field

  @omniauth_test
  Scenario: Login with Facebook creating a new account with no email
    Given a Consumer logs in with Facebook with no email registering an username
    When he is on his settings page
    Then he should not see a "Facebook disconnect" link
