FactoryBot.define do
  sequence :consumer_username do |n|
    "consumer_#{n}"
  end

  sequence :consumer_email do |n|
    "consumer_mail_#{n}@example.com"
  end

  factory :consumer do
    username { generate(:consumer_username) }
    email { generate(:consumer_email) }
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
