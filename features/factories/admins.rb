FactoryBot.define do
  factory :admin do
    username 'admin_one@admin'
    email 'admin_email_one@example.com'
    password 'password'
    password_confirmation 'password'
  end

  factory :second_admin, class: Admin do
    username 'admin_two@admin'
    email 'admin_email_two@example.com'
    password 'password'
    password_confirmation 'password'
  end

  factory :facebook_admin, class: Admin do
    username 'admin_facebook@admin'
    email 'facebook@example.com'
    password 'password'
    password_confirmation 'password'
  end
end
