Feature: Change the fields of a Consumer account

  Scenario: Delete a consumer account
    Given a Consumer is logged in
    When he deletes his account
    Then he should see a "deleted" text

    # TODO: change email