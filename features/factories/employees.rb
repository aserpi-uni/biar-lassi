FactoryBot.define do
  sequence :employee_username do |n|
    "employe_#{n}"
  end

  sequence :employee_email do |n|
    "employee_mail_#{n}@example.com"
  end

  factory :employee do
    enterprise { Enterprise.first || association(:enterprise) }
    username { "#{generate(:employee_username)}@#{enterprise.username_suffix}" }
    email { generate(:employee_email) }
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

  factory :problem_operator, class: Employee do
    enterprise { Enterprise.first }
    username { "problem_operator@#{enterprise.username_suffix}" }
    email 'problem_operator@example.com'
    role { 'operator' }
    password 'password'
    password_confirmation 'password'
  end
end
