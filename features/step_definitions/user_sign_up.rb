When(/^I register an? (Admin|Consumer) with username "([^"]*)" and email "([^"]*)"$/) do |klass, name, email|
  visit path_to("#{klass} sign up")
  fill_in 'username', with: name
  fill_in 'email', with: email
  fill_in 'password', with: 'password'
  fill_in 'password_confirmation', with: 'password'
  click_button 'Register'
end

Given(/^I created (an Admin|a Consumer) account with username "([^"]*)" and email "([^"]*)"$/) do |klass, name, email|
  if klass == 'an Admin' && !Admin.find_by(username: name)
    admin = Admin.new(email: email, password: 'password', username: name)
    admin.save!
  elsif klass == 'a Consumer' && !Consumer.find_by(username: name)
    consumer = Consumer.new(email: email, password: 'password', username: name)
    consumer.skip_confirmation!
    consumer.save!
  end
end

Given(/^I created an Employee account with username "([^"]*)", email "([^"]*)", role "(operator|supervisor)" and enterprise "([^"]*)"$/) do |username, email, role, enterprise|
  Employee.create_new(username: username, email: email, role: role, password: 'password', password_confirmation: 'password',
                      enterprise: enterprise).save!
end

When(/^I register an Employee account with username "([^"]*)", email "([^"]*)", role "(Operator|Supervisor)"( and enterprise "([^"]*)")?$/) do |username, email, role, enterprise|
  visit path_to 'new Employee'
  fill_in 'username', with: username
  fill_in 'email', with: email
  select role, from: 'role'
  fill_in('enterprise', with: enterprise) unless enterprise.blank?
  fill_in 'password', with: 'password'
  fill_in 'password_confirmation', with: 'password'
  click_button 'Create'
end
