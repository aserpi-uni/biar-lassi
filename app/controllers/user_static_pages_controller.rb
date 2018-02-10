class UserStaticPagesController < ApplicationController
  def advice_threads
    authorize :user_static_page
  end

  def consumer
    authorize :user_static_page

    @comments = Comment.find_by_sql("SELECT ct.*
                                     FROM (SELECT c.*
                                           FROM comments AS c
                                           INNER JOIN advice_threads AS a
                                             ON c.domain_type = 'AdviceThread' AND c.domain_id = a.id
                                           INNER JOIN relationships AS r
                                             ON r.followed_type = 'AdviceThread' AND r.followed_id = a.id
                                           WHERE r.consumer_id = #{current_consumer.id}
                                           UNION ALL
                                           SELECT c.*
                                           FROM comments AS c
                                           INNER JOIN problem_threads AS p
                                             ON c.domain_type = 'ProblemThread' AND c.domain_id = p.id
                                           INNER JOIN relationships AS r
                                             ON r.followed_type = 'ProblemThread' AND r.followed_id = p.id
                                           WHERE r.consumer_id = #{current_consumer.id}) AS ct
                                     ORDER BY updated_at DESC")
  end

  def employee
    authorize :user_static_page

    redirect_to current_user if current_employee.supervisor?

    @comments = Comment.find_by_sql("SELECT c.*
                                     FROM comments AS c
                                     INNER JOIN problem_threads AS p
                                       ON c.domain_type = 'ProblemThread' AND c.domain_id = p.id
                                     WHERE p.employee_id = #{current_employee.id}
                                     ORDER BY c.updated_at DESC")
  end

  def problem_threads
    authorize :user_static_page
  end
end
