Feature: Connect to Facebook
  As a Facebook user
  In order to sign in with Facebook
  I want to connect a Facebook account with my Consumer one.


  @omniauth_test
  Scenario: Connect Facebook to an account
    Given I created a Consumer account with username "facebook_success" and email "facebook@example.com"
    And I accurately login as a Consumer with username "facebook_success"
    # OmniAuth has a default configuration
    When I click on the "auth/facebook" link
    Then I should see a "facebook/disconnect" link

  @omniauth_test
  Scenario: Disconnect from Facebook
    Given I am on the "Consumer sign in" page
    And I click on the "/consumers/auth/facebook" link
    And I fill in "username" (in "form" with "action" as "/consumers/facebook/select_username") with "facebook_example"
    And I press "Register" in "form" with "action" as "/consumers/facebook/select_username"
    When I click on the "facebook/disconnect" link
    Then I should see a "auth/facebook" link
