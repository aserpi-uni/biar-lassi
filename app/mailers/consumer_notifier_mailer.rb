class ConsumerNotifierMailer < ApplicationMailer
  default from: 'no-reply@tesi.com'

  def comment_created(comment, consumer)
    @comment = comment
    @consumer = consumer
    mail subject: I18n.t('consumer_notifier_mailer.comment_created.subject'), to: @consumer.email
  end

  def new_solution(comment, consumer)
    @comment = comment
    @consumer = consumer
    mail subject: I18n.t('consumer_notifier_mailer.new_solution.subject'), to: @consumer.email
  end

  def status_update(thread, consumer)
    @advice_thread = thread
    @consumer = consumer
    mail subject: I18n.t('consumer_notifier_mailer.status_update.subject'), to: @consumer.email
  end
end
