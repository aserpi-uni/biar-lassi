class Consumer < ApplicationRecord
  devise :database_authenticatable,
         :confirmable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         #:validatable,
         :omniauthable, :omniauth_providers => [:facebook]


  def self.from_omniauth(auth, username)
    consumer = Consumer.new
    consumer.username = username
    consumer.provider = auth['provider']
    consumer.uid = auth['uid']
    consumer.email = auth['info']['email']
    consumer.password = Devise.friendly_token[0,20]

    consumer.skip_confirmation!
    consumer.save!

    consumer

    # user.name = auth.info.name   # assuming the user model has a name
    # user.image = auth.info.image # assuming the user model has an image
  end
end
