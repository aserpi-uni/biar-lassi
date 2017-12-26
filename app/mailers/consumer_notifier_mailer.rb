class ConsumerNotifierMailer < ApplicationMailer
  default from: 'no-reply@tesi.com'

  def send_consumer_notify(consumer, thread, product)
    @consumer = consumer
    @thread = thread
    @product = product
    mail( :to => @consumer.email,
          :subject => 'Referent reply to problem thread regarding product: '+ @product.model + ';title: ' + @thread.title )
  end
end
