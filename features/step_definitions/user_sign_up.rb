When(/^I accurately register an? (Admin|Consumer) with username "([^"]*)" and email "([^"]*)"$/) do |klass, name, email|
  klass = klass.downcase
  fill_in "#{klass}_username", with: name
  fill_in "#{klass}_email", with: email
  fill_in "#{klass}_password", with: 'password'
  fill_in "#{klass}_password_confirmation", with: 'password'
  click_button 'Register'
end
