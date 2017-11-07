Feature: Connect to Facebook
  As a Facebook user
  In order to sign in with Facebook
  I want to connect a Facebook account with my Consumer one.


  @omniauth_test
  Scenario: Connect and disconnect a Facebook account
    Given a Consumer is logged in
    And he connects to Facebook
    # OmniAuth's default configuration has a non-null email
    When he disconnects from Facebook
    Then he should see a "Facebook connect" link
