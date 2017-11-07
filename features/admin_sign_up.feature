Feature: Admin sign up
  As an Admin
  In order to expand the site's staff
  I want to be able to create new Admin accounts

  Background:
    Given an Admin is logged in

  Scenario: Create a new account
    When he creates a new Admin
    Then he should not see a "username" input field

  Scenario: Try to create a new account with a wrong password confirmation
    When he creates a new Admin with wrong password confirmation
    Then he should see a "username" input field

  Scenario: Try to create a new account with a username already taken
    When he creates a new Admin with a username already taken
    Then he should see a "username" input field

  Scenario: Try to create a new account with an email already taken
    When he creates a new Admin with an email already taken
    Then he should see a "username" input field
