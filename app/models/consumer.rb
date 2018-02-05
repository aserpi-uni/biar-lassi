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
  has_many :problem_threads, dependent: :destroy
  has_many :advice_threads, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  #has_many :advice_comments, as: :commentable, dependent: :destroy


  # following charasteristics and functions

  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy

  has_many :following, through: :active_relationships, source: :followed

  def feed
    following_ids = "SELECT followed_id from relationships WHERE follower_id = :consumer_id"
    Comment.where("problem_thread_id in (#{following_ids}) OR commentable_id = :consumer_id AND commentable_type = :consumer", consumer_id: id, consumer: Consumer)
    #Comment.where("problem_thread_id in (?)", following_ids)
  end

  def follow(problem_thread)
    active_relationships.create(followed_id: problem_thread.id)
  end

  def unfollow(problem_thread)
    active_relationships.find_by(followed_id: problem_thread.id).destroy
  end

  def follow? (problem_thread)
    following.include?(problem_thread)
  end

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,
                              message: I18n.t(:field_invalid) },
                    user_uniqueness: true, allow_blank: true, consumer_authentication: true

  validates :password, confirmation: true, length: { in: 8..128 }, on: :create
  validates :password, confirmation: true, length: { in: 8..128 }, allow_blank: true, on: :update

  validates :username, format: { with: /\A\w{5,32}\z/, message: I18n.t(:field_invalid) }, reserved_name: true,
                       uniqueness: { case_sensitive: false }, on: :create

  # Creates a new Consumer from an OmniAuth response and info inserted by the user.
  def self.from_omniauth(auth, params)
    consumer = Consumer.new

    consumer.assign_attributes params
    consumer.assign_attributes email: auth['info']['email'], provider: auth['provider'], uid: auth['uid']

    # Skips confirmation if the email is provided by Facebook or there is no email
    consumer.skip_confirmation! if
      (consumer.email = auth['info']['email'].presence) ||
      !(consumer.email = params[:email].presence)

    consumer
  end

  # Connects a Consumer with Facebook
  def facebook_connect(auth)
    self.provider = auth[:provider]
    self.uid = auth[:uid]
    save
  end

  # Disconnects a Consumer from Facebook
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
