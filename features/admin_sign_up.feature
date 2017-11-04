Feature: Admin sign up
  As an Admin
  In order to expand the site's staff
  I want to be able to create new Admin accounts

  Background:
    Given I created an Admin account with username "username" and email "admin@example.com"
    And I login as an Admin with username "username@admin"
    And I am on the "new Admin" page

  Scenario: Create a new account
    And I fill in "username" with "admin_success"
    And I fill in "email" with "amdin_success@example.com"
    And I fill in "password" with "password"
    And I fill in "password_confirmation" with "password"
    When I press "Create"
    Then I should not see a "username" input field

  Scenario: Try to create a new account with a wrong password confirmation
    And I fill in "username" with "admin_fail"
    And I fill in "email" with "admin_fail@example.com"
    And I fill in "password" with "password"
    And I fill in "password_confirmation" with "wrong_password"
    When I press "Create"
    Then I should see a "username" input field

  Scenario: Try to create a new account with an username already taken
    When I register an Admin with username "username" and email "admin_2@example.com"
    Then I should see a "username" input field

  Scenario: Try to create a new account with an email already taken
    When I register an Admin with username "admin_fail" and email "admin@example.com"
    Then I should see a "username" input field
