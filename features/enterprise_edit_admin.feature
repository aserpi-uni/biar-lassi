Feature: Editing and Enterprise
  As a Admin
  In order to track changes in real world
  I want to be able to edit an Enterprise's name and username suffix.

  Background:
    Given I created an Admin account with username "adminaccount" and email "admin@example.com"
    And I login as an Admin with username "adminaccount"
    And I created an Enterprise with name "Enterprise" and username suffix "enter"
    And I created an Employee account with username "employee", email "supervisor@example.com", role "supervisor" and enterprise "Enterprise"
    And I am on the "edit" page for Enterprise "Enterprise"

  Scenario: Admin successfully edits the username_suffix
    Given I fill in "username_suffix" with "enter2"
    When I press "Save"
    Then I should see a "1 employee username" text

  Scenario: Admin tries to edit the username_suffix
    Given I created an Enterprise with name "Enterprise2" and username suffix "enter2"
    And I fill in "username_suffix" with "enter2"
    When I press "Save"
    Then I should not see a "1 employee username" text
