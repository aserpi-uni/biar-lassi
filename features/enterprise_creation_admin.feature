Feature: Enterprise creation (as an Admin)
  As an Admin
  In order to add an Enterprise in the framework
  I want to be able to create a new Enterprise resource and a related Supervisor employee.

  # TODO: modificare username quando ci saranno gli admin

  Background:
    Given I created an Admin account with username "username" and email "admin@example.com"
    And I login as an Admin with username "username"

  Scenario: Successfully create an Enterprise
    When I create an Enterprise with name "enterprise" and nickname suffix "nick_suffix"
    Then I should not see a "enterprise_name" input field

  Scenario: Try to create an Enterprise with an already taken name
    Given I created an Enterprise with name "enterprise" and nickname suffix "nick_suffix"
    When I create an Enterprise with name "enterprise" and nickname suffix "other_suffix"
    Then I should see a "enterprise_name" input field


  Scenario: Try to create an Enterprise with an already taken nickname suffix
    Given I created an Enterprise with name "enterprise" and nickname suffix "nick_suffix"
    When I create an Enterprise with name "other_enterprise" and nickname suffix "nick_suffix"
    Then I should see a "enterprise_name" input field
