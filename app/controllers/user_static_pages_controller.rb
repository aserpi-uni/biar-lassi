class UserStaticPagesController < ApplicationController
  def advice_threads
    authorize :user_static_page
  end

  def comments
    authorize :user_static_page

    @comments = current_consumer ? consumer_comments : operator_comments
  end

  def consumer
    authorize :user_static_page

    @comments = consumer_comments
  end

  def employee
    authorize :user_static_page

    redirect_to current_user if current_employee.supervisor?

    @comments = operator_comments
  end

  def problem_threads
    authorize :user_static_page
  end

  private

  def consumer_comments
    comment_advice_ids = "SELECT c.id
                          FROM comments AS c
                          INNER JOIN advice_threads AS a
                            ON c.domain_type = 'AdviceThread' AND c.domain_id = a.id
                          INNER JOIN relationships AS r
                            ON r.followed_type = 'AdviceThread' AND r.followed_id = a.id
                          WHERE r.consumer_id = #{current_consumer.id}"
    comment_problem_ids = "SELECT c.id
                           FROM comments AS c
                           INNER JOIN problem_threads AS p
                             ON c.domain_type = 'ProblemThread' AND c.domain_id = p.id
                           INNER JOIN relationships AS r
                             ON r.followed_type = 'ProblemThread' AND r.followed_id = p.id
                           WHERE r.consumer_id = #{current_consumer.id}"

    Comment.where("id IN (#{comment_advice_ids}) OR id IN (#{comment_problem_ids})").order(updated_at: :desc)
  end

  def operator_comments
    comment_problem_ids = "SELECT c.id
                           FROM comments AS c
                           INNER JOIN problem_threads AS p
                             ON c.domain_type = 'ProblemThread' AND c.domain_id = p.id
                           WHERE p.employee_id = #{current_employee.id}"

    Comment.where("id IN (#{comment_problem_ids})").order(updated_at: :desc)
  end
end
