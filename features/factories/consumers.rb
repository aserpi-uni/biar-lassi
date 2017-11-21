FactoryBot.define do
  factory :consumer do
    username 'consumer_one'
    email 'consumer_email_one@example.com'
    password 'password'
    password_confirmation 'password'
  end

  factory :facebook_consumer, class: Consumer do
    username 'consumer_facebook'
    email 'facebook@example.com'
    password 'password'
    password_confirmation 'password'
    confirmed_at Time.now
  end
end
