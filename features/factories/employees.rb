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

  factory :problem_operator, class: Employee do
    enterprise { Enterprise.first }
    username { "problem_operator@#{enterprise.username_suffix}" }
    email 'problem_operator@example.com'
    role { 'operator' }
    password 'password'
    password_confirmation 'password'
  end
end
