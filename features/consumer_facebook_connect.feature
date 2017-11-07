Feature: Connect to Facebook
  As a Facebook user
  In order to sign in with Facebook
  I want to connect a Facebook account with my Consumer one.

  @omniauth_test
  Scenario: Connect a Consumer account with Facebook
    Given a Consumer is logged in
    When he connects his account to Facebook
    Then he should see a "Facebook disconnect" link

  @omniauth_test
  Scenario: Disconnect from Facebook
    Given a Consumer logs in with Facebook registering a username
    When he disconnects his account from Facebook
    Then he should see a "Facebook connect" link

  @omniauth_test
  Scenario: Login with Facebook creating a new account with no email
    Given a Consumer logs in with Facebook with no email registering a username
    When he is on his settings page
    Then he should not see a "Facebook disconnect" link
