Feature: Signing up as a consumer
  In order to access the site
  as a Consumer
  I want to create a new account

  Scenario: Create a new account with success
    When a Consumer registers an account
    Then he should not see a "username" input field

  Scenario: Try to create a new account with a password too short
    When a Consumer registers an account with a password too short
    Then he should see a "username" input field

  Scenario: Try to create a new account with a wrong password confirmation
    When a Consumer registers an account with a wrong password confirmation
    Then he should see a "username" input field

  Scenario: Try to create a new account with a username already taken
    Given a Consumer has a confirmed account
    When a Consumer registers an account with a username already taken
    Then he should see a "username" input field

  Scenario: Try to create a new account with an email already taken
    Given an Admin has an account
    When a Consumer registers an account with an email already taken by an Admin
    Then he should see a "username" input field

  Scenario: Try to create a new account with an incorrect username
    When a Consumer registers an account with an incorrect username
    Then he should see a "username" input field

  Scenario: Try to create a new account with a reserved username
    When a Consumer registers an account with a reserved username
    Then he should see a "username" input field
