class Consumer < ApplicationRecord
  devise :database_authenticatable,
         :confirmable,
         :lockable,
         :recoverable,
         :registerable,
         :rememberable,
         :trackable,
         :omniauthable, omniauth_providers: [:facebook]

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: 'invalid' },
                    unique: { global: true }, on: :create
  validates :password, confirmation: true, length: { in: 8..128 }, on: :create
  validates :username, format: { with: /\A\w{5,32}\z/, message: 'invalid' }, reserved_name: true,
                       unique: { global: false }, on: :create

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: 'invalid' },
                    allow_blank: true, on: :update
  validates :password, confirmation: true, length: { in: 8..128 }, allow_blank: true, on: :update

  def to_param
    username
  end

  def self.from_omniauth(auth, username, email)
    consumer = Consumer.new
    consumer.username = username
    consumer.provider = auth['provider']
    consumer.uid = auth['uid']
    consumer.email = auth['info']['email']
    consumer.password = Devise.friendly_token[0, 8]
    consumer.password_confirmation = consumer.password

    if consumer.email.blank?
      if email.blank?
        consumer.email = 'null@example.com'
        consumer.skip_confirmation!
      else
        consumer.email = email
      end
    else
      consumer.skip_confirmation!
    end

    consumer.save!

    if consumer.valid? && auth['info']['email'].blank? && email.blank?
      consumer.email = nil
      consumer.save validate: false
    end

    consumer
  end
end
