class UserStaticPagesController < ApplicationController
  def advice_threads
    authorize :user_static_page
  end

  def consumer
    authorize :user_static_page
  end

  def employee
    authorize :user_static_page

    redirect_to current_user if current_employee.supervisor?
  end

  def problem_threads
    authorize :user_static_page
  end

end
