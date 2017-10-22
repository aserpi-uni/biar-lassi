Feature: Connect to Facebook
  As a Facebook user
  In order to sign in with Facebook
  I want to connect a Facebook account with my Consumer one.


  @omniauth_test
  Scenario: Connect Facebook to an account
    Given I created a Consumer account with username "username" and email "facebook@example.com"
    And I login as a Consumer with username "username"
    When I click on the "/auth/consumers/auth/facebook" link
    # OmniAuth's default configuration has a non-null email
    Then I should see a "/auth/consumers/facebook/disconnect" link

  @omniauth_test
  Scenario: Disconnect from Facebook
    Given I login with Facebook registering the username "facebook"
    # OmniAuth's default configuration has a non-null email
    When I click on the "/auth/consumers/facebook/disconnect" link
    Then I should see a "/auth/consumers/auth/facebook" link
