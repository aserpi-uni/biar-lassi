# An end user that can post new +remarks+ and +comments+. # FIXME
#
# *Parameters:*
# * +username+ [String]  user public identification
# * +email+ [String]     user's email address
# * others               See https://github.com/plataformatec/devise
class Consumer < ApplicationRecord
  include UserState

  devise :database_authenticatable,
         :confirmable,
         :lockable,
         :recoverable,
         :registerable,
         :rememberable,
         :trackable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :posts, dependent: :destroy





  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: I18n.t(:field_invalid) },
                    user_uniqueness: true, allow_blank: true, consumer_authentication: true

  validates :password, confirmation: true, length: { in: 8..128 }, on: :create
  validates :password, confirmation: true, length: { in: 8..128 }, allow_blank: true, on: :update

  validates :username, format: { with: /\A\w{5,32}\z/, message: I18n.t(:field_invalid) }, reserved_name: true,
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
  def facebook_connect(auth)
    self.provider = auth[:provider]
    self.uid = auth[:uid]
    save
  end

  def facebook_disconnect
    self.provider = nil
    self.uid = nil
    save
  end

  def soft_delete
    self.provider = nil
    self.uid = nil
    super
  end


  def to_param
    username
  end
end
