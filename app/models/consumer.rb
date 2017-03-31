class Consumer < ApplicationRecord
  devise :database_authenticatable,
         :confirmable,
         :lockable,
         :recoverable,
         :registerable,
         :rememberable,
         :trackable,
         :omniauthable, omniauth_providers: [:facebook]

  validates :email, format: {with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: 'invalid' }
  validates :email, unique: true, on: :create
  validates :password, confirmation: true, length: { in: 8..128 }
  validates :password_confirmation, presence: true
  validates :username, unique: true, on: :create

  def to_param
    username
  end

  def self.from_omniauth(auth, username, email)
    consumer = Consumer.new
    consumer.username = username
    consumer.provider = auth['provider']
    consumer.uid = auth['uid']
    consumer.email = auth['info']['email'] || email || 'null@null.com'
    consumer.password = Devise.friendly_token[0, 8]
    consumer.password_confirmation = consumer.password

    consumer.skip_confirmation!
    consumer.save!

    if consumer.valid? && auth['info']['email'].blank? && email.blank?
      consumer.email = nil
      consumer.save validate: false
    end

    consumer
  end
end
