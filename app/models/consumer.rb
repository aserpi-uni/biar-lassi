# An end user of the website.
class Consumer < ApplicationRecord
  devise :database_authenticatable,
         :confirmable,
         :lockable,
         :recoverable,
         :registerable,
         :rememberable,
         :trackable,
         :omniauthable, omniauth_providers: [:facebook]



  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: 'is invalid' },
                    user_uniqueness: true, allow_blank: true, consumer_authentication: true

  validates :password, confirmation: true, length: { in: 8..128 }, on: :create
  validates :password, confirmation: true, length: { in: 8..128 }, allow_blank: true, on: :update

  validates :username, format: { with: /\A\w{5,32}\z/, message: 'is invalid' }, reserved_name: true,
                       uniqueness: { case_sensitive: false }, on: :create



  # Creates a new Consumer from an OmniAuth response and info inserted by the user.
  def self.from_omniauth(auth, username, email, password, password_confirmation)
    consumer = Consumer.new
    consumer.username = username
    consumer.provider = auth['provider']
    consumer.uid = auth['uid']
    consumer.password = password
    consumer.password_confirmation = password_confirmation

    # Skips confirmation if the email is provided by Facebook or there is no email
    consumer.skip_confirmation! if
      (consumer.email = auth['info']['email'].presence) ||
      !(consumer.email = email.presence)

    consumer
  end


  # Connects a Consumer with Facebook
  def connect_facebook(auth)
    self.provider = auth[:provider]
    self.uid = auth[:uid]
    save
  end


  # Locks a Consumer out of his account with no possibility of recover.
  def lock
    self.email = nil
    self.locked_at = Time.now
    self.provider = nil
    self.uid = nil
    save
  end


  def to_param
    username
  end
end
