Given(/^an? (Admin|Consumer|Employee) account with the same email as a Facebook one$/) do |klass|
  klass = "facebook_#{klass.downcase}"
  instance_variable_set("@#{klass}", FactoryBot.create(klass))
end

Given(/^an? (.*) has (a confirmed|an) account$/) do |klass, confirmed|
  klass = klass.parameterize.underscore
  instance_variable_set("@#{klass}", FactoryBot.create(klass))
  instance_variable_get("@#{klass}").update(confirmed_at: Time.now) if confirmed == 'a confirmed'
  @enterprise = instance_variable_get("@#{klass}").enterprise if employee? klass
end


## Admin and Employee create

When(/^he creates a new (Admin|Employee|Operator|Supervisor)$/) do |res|
  visit path_to("new #{res}")
  res = res.downcase
  fill_register_form("#{res}_two", "#{res}_email_two@example.com")
  if employee? res
    fill_in 'enterprise', with: @enterprise.name if @current_user.is_a? Admin
    select Employee.roles.keys.sample.capitalize, from: 'role'
  end
  click_button I18n.t(:create)
end

When(/^he creates a new (Admin|Employee) with an? (.*) already taken$/) do |klass, field|
  create_wrong_admin_or_employee klass, field, instance_variable_get("@#{klass.downcase}").send(field.parameterize.underscore)
end

When(/^he creates a new (Admin|Employee) with wrong (.*)$/) do |klass, field|
  create_wrong_admin_or_employee klass, field, ' '
end

When(/^he creates a new Employee with a nonexistent Enterprise$/) do
  visit path_to 'new Employee'
  fill_register_form('employee_two', 'employee_email_two@example.com')
  select Employee.roles.keys.sample.capitalize, from: 'role'
  fill_in :enterprise, with: 'nonexistent'
  click_button I18n.t(:create)
end


## Consumer sign up

Given(/^a Consumer registers an account$/) do
  visit path_to('Consumer sign up')
  fill_consumer_register_form('consumer_one', 'consumer_email_one@example.com')
  click_button I18n.t(:sign_up)
end

Given(/^a Consumer registers an account with an? (email|username) already taken( by an? (Admin|Consumer|Employee))?$/) do |attr, klass|
  visit path_to('Consumer sign up')
  usr = klass ? instance_variable_get("@#{klass.downcase}") : @consumer

  if attr == 'username'
    fill_consumer_register_form(usr.username, 'consumer_username_taken@example.com')
  elsif attr == 'email'
    fill_consumer_register_form('consumer_email_taken', usr.email)
  end

  click_button I18n.t(:sign_up)
end

Given(/^a Consumer registers an account with a password too short$/) do
  visit path_to('Consumer sign up')
  fill_consumer_register_form('consumer_one', 'consumer_email_one@example.com', pwd: 'pwd', pwd_confirm: 'pwd')
  click_button I18n.t(:sign_up)
end

Given(/^a Consumer registers an account with a wrong password confirmation$/) do
  visit path_to('Consumer sign up')
  fill_consumer_register_form('consumer_one', 'consumer_email_one@example.com', pwd_confirm: 'wrong_pwd')
  click_button I18n.t(:sign_up)
end

When(/^a Consumer registers an account with an? (incorrect|reserved) username$/) do |err|
  visit path_to('Consumer sign up')
  name = err == 'incorrect' ? 'consumer@something' : ENV['RESERVED_NAMES'].tr('"', '').split.sample
  fill_consumer_register_form(name, 'consumer_email_one@example.com')
  click_button I18n.t(:sign_up)
end



private

def create_wrong_admin_or_employee(klass, field, value)
  visit path_to("new #{klass}")
  klass = klass.downcase
  fill_register_form("#{klass}_two", "#{klass}_email_two@example.com")
  fill_in field.parameterize.underscore, with: value
  click_button I18n.t(:create)
end

def fill_consumer_register_form(name, email, pwd: 'password', pwd_confirm: pwd)
  fill_register_form(name, email)
  fill_in 'password', with: pwd
  fill_in 'password_confirmation', with: pwd_confirm
end

def fill_register_form(name, email)
  fill_in 'username', with: name
  fill_in 'email', with: email
end
