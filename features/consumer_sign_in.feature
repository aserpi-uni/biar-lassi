Feature: Signing in as a consumer
  In order to access the site
  as a Consumer
  I want to sign in with a pre-existing account or Facebook

  Scenario: Log in with a pre-existing account
    Given a Consumer has a confirmed account
    When the Consumer logs in
    Then he should see a "Consumer sign out" link

  Scenario: Try to log in with an unconfirmed account
    Given a Consumer has an account
    When the Consumer logs in
    Then he should not see a "Consumer sign out" link

  Scenario: Try to log in with a nonexistent account
    When a Consumer logs in with a nonexistent account
    Then he should see a "username" input field

  Scenario: Try to log in with a wrong password
    Given a Consumer has a confirmed account
    When the Consumer logs in with incorrect credentials
    Then he should see a "username" input field

  Scenario: Try to login even if already logged in as a Consumer
    Given a Consumer is logged in
    When he is on the "Consumer sign in" page
    Then he should not see a "username" input field

  Scenario: Try to login even if already logged in as an Admin
    Given an Admin is logged in
    When he is on the "Consumer sign in" page
    Then he should not see a "username" input field
