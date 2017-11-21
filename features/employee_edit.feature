Feature: Edit an employee

  Scenario: An Admin changes the email address of an Operator
    Given an Operator has an account
    And an Admin is logged in
    And he is on the Operator's settings page
    And he changes the "email" field to "operator_email_two@example.com"
    When he saves
    Then he should see a "email" input field with value "operator_email_two@example.com"


#  Scenario: TODO: An Admin changes the role of an Operator
#    Given an Operator has an account
#    And an Admin is logged in
#    And he is on the Operator's settings page
#    And he changes the "role" field to "supervisor"
#    When he saves
#    Then he should see WAHT?

  Scenario: An Admin locks and unlocks an Employee
    Given an Employee has an account
    And an Admin is logged in
    And he locks the Employee account
    When he unlocks the Employee account
    Then he should see a "unlocked" text

  Scenario: An Admin deletes a Supervisor
    Given a Supervisor has an account
    And an Admin is logged in
    When he deletes the Supervisor account
    Then he should see a "deleted" text

  Scenario: A Supervisor locks his account
    Given a Supervisor is logged in
    And he locks the Supervisor account
    When the Supervisor logs in
    Then he should see a "locked" text

  Scenario: A Supervisor deletes his account
    Given a Supervisor is logged in
    And he deletes his account
    When the Supervisor logs in
    Then he should see a "locked" text

  Scenario: An Operator tries to access his settings
    Given an Operator is logged in
    When he is on his settings page
    Then he should see a "authorized" text
