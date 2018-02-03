# An end user.
#
# *Parameters:*
# * +username+ [String]  user public identification
# * +email+ [String]     user's email address
# * others               See https://github.com/plataformatec/devise
#
# *Associations:*
# * +has_many+ [Comment]          comments posted by the user
# * +has_many+ [DownVote]         negative votes posted by the user
# * +has_many+ [ProblemThread]    problem threads opened by the consumer
# * +has_many+ [UpVote]           positive votes posted by the user
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

  has_many :comments, as: :author, dependent: :destroy
  has_many :down_votes, as: :downer, dependent: :destroy
  has_many :problem_threads, inverse_of: 'author'
  has_many :up_votes, as: :upper, dependent: :destroy

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }, allow_blank: true,
                    consumer_authentication: true, user_uniqueness: true

  validates :password, confirmation: true, length: { in: 8..128 }, on: :create
  validates :password, confirmation: true, length: { in: 8..128 }, allow_blank: true, on: :update

  validates :username, format: { with: /\A\w{5,32}\z/ }, reserved_name: true, uniqueness: { case_sensitive: false },
                       on: :create

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

  # TODO

  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed

  def feed
    Comment.none
    #following_ids = 'SELECT followed_id from relationships WHERE follower_id = :consumer_id'
    #Comment.where("problem_thread_id in (#{following_ids}) OR commentable_id = :consumer_id AND commentable_type = :consumer", consumer_id: id, consumer: Consumer)
    #Comment.where("problem_thread_id in (?)", following_ids)
  end

  def follow(problem_thread)
    Relationship.create(followed: problem_thread, follower: self)
  end

  def unfollow(problem_thread)
    active_relationships.find_by(followed_id: problem_thread.id).destroy
  end

  def follow?(problem_thread)
    following.include?(problem_thread)
  end
end
