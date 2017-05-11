When(/^I accurately login as an? (Admin|Consumer) with username "([^"]*)"$/) do |klass, name|
  visit path_to("#{klass} sign in")
  klass = klass.downcase
  fill_in "#{klass}_username", with: name
  fill_in "#{klass}_password", with: 'password'
  click_button 'Login'
end


And(/^I click on the "([^"]*)" link$/) do |arg|
  find(:xpath, "//a[@href=\"#{arg}\"]").click
end


And(/^I want to login with Facebook with "([^"]*)" as email$/) do |arg|
  OmniAuth.config.add_mock :facebook, :info => { :email => '' }
end