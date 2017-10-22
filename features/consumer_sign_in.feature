Feature: Signing in as a consumer
  In order to access the site
  as a Consumer
  I want to sign in with a pre-existing account or Facebook


  Scenario: Log in with a pre-existing account
    Given I created a Consumer account with username "username" and email "email@example.com"
    When I login as a Consumer with username "username"
    Then I should see a "/auth/consumers/sign_out" link

  Scenario: Try to log in with a nonexistent account
    When I login as a Consumer with username "nonexistent"
    Then I should see a "consumer_username" input field

  Scenario: Try to log in with a wrong password
    Given I created a Consumer account with username "username" and email "email@example.com"
    And I am on the "Consumer sign in" page
    And I fill in "consumer_username" with "username"
    And I fill in "consumer_password" with "wrong_password"
    When I press "Login"
    Then I should see a "consumer_username" input field

  Scenario: Try to login even if already logged in as a Consumer
    Given I created a Consumer account with username "username" and email "email@example.com"
    And I login as a Consumer with username "username"
    When I am on the "Consumer sign in" page
    Then I should see a "/auth/consumers/sign_out" link

    # TODO: modificare username quando ci saranno gli admin
  Scenario: Try to login even if already logged in as a Consumer
    Given I created an Admin account with username "username" and email "email@example.com"
    And I login as an Admin with username "username"
    When I am on the "Consumer sign in" page
    Then I should see a "/auth/consumers/sign_out" link
