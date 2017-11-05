Given(/^I created (an Admin|a Consumer) account with username "([^"]*)" and email "([^"]*)"$/) do |klass, name, email|
  if klass == 'an Admin'
    name = "#{name}@admin"
    unless Admin.find_by(username: name)
      admin = Admin.new(username: name, email: email, password: 'password')
      admin.save!
    end
  elsif klass == 'a Consumer' && !Consumer.find_by(username: name)
    consumer = Consumer.new(email: email, password: 'password', username: name)
    consumer.skip_confirmation!
    consumer.save!
  end
end

Given(/^I created an Employee account with username "([^"]*)", email "([^"]*)", role "(operator|supervisor)" and enterprise "([^"]*)"$/) do |username, email, role, enterprise|
  Employee.from_params(username: username, email: email, role: role, password: 'password', password_confirmation: 'password',
                       enterprise: enterprise).save!
end

When(/^I register an Admin with username "([^"]*)" and email "([^"]*)"$/) do |name, email|
  visit path_to('new Admin')
  fill_register_form(name, email)
  click_button 'Create'
end


When(/^I register a Consumer with username "([^"]*)" and email "([^"]*)"$/) do |name, email|
  visit path_to('Consumer sign up')
  fill_register_form(name, email)
  click_button 'Register'
end

When(/^I register an Employee account with username "([^"]*)", email "([^"]*)", role "(Operator|Supervisor)"( and enterprise "([^"]*)")?$/) do |username, email, role, enterprise|
  visit path_to 'new Employee'
  fill_register_form(username, email)
  select role, from: 'role'
  fill_in('enterprise', with: enterprise) unless enterprise.blank?
  click_button 'Create'
end



private

def fill_register_form(name, email)
  fill_in 'username', with: name
  fill_in 'email', with: email
  fill_in 'password', with: 'password'
  fill_in 'password_confirmation', with: 'password'
end