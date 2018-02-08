Feature: Comment creation (as a non-Consumer or a non-Employee)
  As a Consumer or Employee
  In order to answer to a problem thread or an advice thread
  I want to be able to create a new comment


  Scenario: Try to create a new Problem Thread Comment by Supervisor
    Given a Supervisor is logged in
    When he creates a new ProblemThreadCommentE
    Then he should see a "content" input field


  Scenario: Try to create a new Advice Thread Comment by Supervisor
    Given a Supervisor is logged in
    When he creates a new AdviceThreadCommentE
    Then he should see a "content" input field

  Scenario: Try to create a new Problem Thread Comment when not logged in
    When he creates a new ProblemThreadCommentE
    Then he should see a "content" input field

  Scenario: Try to create a new Advice Thread Comment when not logged in
    When he creates a new AdviceThreadCommentE
    Then he should see a "content" input field