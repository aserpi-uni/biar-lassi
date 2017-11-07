Feature: Editing and Enterprise
  As a Supervisor
  In order to better represent my Enterprise
  I want to be able to edit my organization's public information

  Scenario: Supervisor changes the website
    Given a Supervisor is logged in
    And he is on the Enterprise's settings page
    And he changes the "website" field to "https://example.com"
    When he saves
    Then he should see a "website" input field with value "https://example.com"

  Scenario: Operator tries to edit the Enterprise
    Given an Operator is logged in
    And he is on the Enterprise's settings page
    Then he should see a "authorized" text
