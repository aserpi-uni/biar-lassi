class ReferentNotifierMailer < ApplicationMailer
  default from: 'no-reply@tesi.com'

  def comment_created(comment)
    @comment = comment
    mail subject: I18n.t('referent_notifier_mailer.comment_created.subject'), to: @comment.domain.employee.email
  end

  def new_solution(comment)
    @comment = comment
    mail subject: I18n.t('referent_notifier_mailer.new_solution.subject'), to: @comment.domain.employee.email
  end

  def problem_thread_created(problem_thread)
    @problem_thread = problem_thread
    mail subject: I18n.t('referent_notifier_mailer.problem_thread_created.subject'), to: @problem_thread.employee.email
  end

  def problem_thread_updated(problem_thread)
    @problem_thread = problem_thread
    mail subject: I18n.t('referent_notifier_mailer.problem_thread_updated.subject'), to: @problem_thread.employee.email
  end
end
