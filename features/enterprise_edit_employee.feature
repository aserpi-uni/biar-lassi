Feature: Editing and Enterprise
  As a Supervisor
  In order to better represent my Enterprise
  I want to be able to edit my organization's public information

  Background:
    Given I created an Enterprise with name "Enterprise" and username suffix "enter"

  Scenario: Supervisor changes the website
    Given I created an Employee account with username "employee", email "supervisor@example.com", role "supervisor" and enterprise "Enterprise"
    And I login as an Employee with username "employee@enter"
    And I am on the "edit" page for Enterprise "Enterprise"
    Given I fill in "website" with "https://example.com"
    When I press "Save"
    Then I should not see a "error" text

  Scenario: Operator tries to edit the Enterprise
    Given I created an Employee account with username "employee", email "supervisor@example.com", role "operator" and enterprise "Enterprise"
    And I login as an Employee with username "employee@enter"
    When I am on the "edit" page for Enterprise "Enterprise"
    Then I should see a "authorized" text
