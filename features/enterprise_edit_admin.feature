Feature: Editing and Enterprise
  As a Admin
  In order to track changes in real world
  I want to be able to edit an Enterprise's name and username suffix.

  Background:
    Given an Admin is logged in
    And an Employee has an account
    And he is on the Enterprise's settings page

  Scenario: Admin successfully edits the username_suffix
    Given he changes the "username_suffix" field to "enter_two"
    When he saves
    Then he should see a "1 employee username" text

  Scenario: Admin tries to edit the username_suffix
    Given a second Enterprise
    And he changes the "username_suffix" field to "enter_two"
    When he saves
    Then he should not see a "1 employee username" text

  Scenario: Admin deletes an Enterprise
    # TODO: when Product
