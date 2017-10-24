Feature: Connect to Facebook
  As a Facebook user
  In order to sign in with Facebook
  I want to connect a Facebook account with my Consumer one.


  @omniauth_test
  Scenario: Connect and disconnect a Facebook account
    Given I created a Consumer account with username "username" and email "facebook@example.com"
    And I login as a Consumer with username "username"
    And I am on the "Consumer settings" page
    And I click on the "/auth/consumers/auth/facebook" link
    And I am on the "Consumer settings" page
    # OmniAuth's default configuration has a non-null email
    When I click on the "/auth/consumers/facebook/disconnect" link
    Then I should see a "/auth/consumers/auth/facebook" link
