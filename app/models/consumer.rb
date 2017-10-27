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
            global_uniqueness: true, allow_blank: true, consumer_authentication: true

  validates :password, confirmation: true, length: { in: 8..128 }, on: :create
  validates :password, confirmation: true, length: { in: 8..128 }, allow_blank: true, on: :update

  validates :username, format: { with: /\A\w{5,32}\z/, message: 'is invalid' }, reserved_name: true,
            uniqueness: { case_sensitive: false }, on: :create


  def to_param
    username
  end

  def self.from_omniauth(auth, username, email)
    consumer = Consumer.new
    consumer.username = username
    consumer.provider = auth['provider']
    consumer.uid = auth['uid']
    consumer.password = Devise.friendly_token[0, 8]
    consumer.password_confirmation = consumer.password
    if auth['info']['email'].blank?
      if email.blank?
        consumer.skip_confirmation!
      else
        consumer.email = email
      end
    else
      consumer.email = auth['info']['email']
      consumer.skip_confirmation!
    end

    consumer
  end

  def lock
    self.email = nil
    self.locked_at = Time.now
    self.provider = nil
    self.uid = nil
    save
  end
end
