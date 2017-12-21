class ReferentNotifierMailer < ApplicationMailer
  default from: 'no-reply@tesi.com'

  def new_referent_notify(referent, thread, product)
    @referent = referent
    @thread = thread
    @product = product
    mail( :to => @referent.email,
          :subject => 'New problem thread assigned regarding product: '+ @product.model + ';title: ' + @thread.title )
  end

  def send_referent_notify(referent, thread, product)
    @referent = referent
    @thread = thread
    @product = product
    mail( :to => @referent.email,
          :subject => 'Reply from owner of problem thread (product: '+ @product.model + ') titled:' + @thread.title )
  end

  def solution_found_notify(referent, thread, product)
    @referent = referent
    @thread = thread
    @product = product
    mail( :to => @referent.email,
          :subject => 'Solution found to problem thread titled:' + @thread.title )
  end
end
