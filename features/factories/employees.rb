FactoryBot.define do
  factory :employee do
    enterprise
    username { "employee_one@#{enterprise.username_suffix}" }
    email 'employee_email_one@example.com'
    role { Employee.roles.keys.sample }
    password 'password'
    password_confirmation 'password'

    factory :supervisor do
      role 'supervisor'
    end

    factory :operator do
      role 'operator'
    end
  end
end
