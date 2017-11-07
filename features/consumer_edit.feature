Feature: Change the attributes of a Consumer account

  Scenario: Change the email address of a consumer
    Given a Consumer is logged in
    And he is on his settings page
    When he changes the "email" field to "consumer_email_two@example.com"
    Then he should see a "email" input field with value "consumer_email_two@example.com"

  Scenario: Delete a consumer account
    Given a Consumer is logged in
    When he deletes his account
    Then he should see a "deleted" text
