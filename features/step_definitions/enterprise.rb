Given(/^I created an Enterprise with name "([^"]*)" and username suffix "([^"]*)"$/) do |name, username_suffix|
  enterprise = Enterprise.new(name: name, username_suffix: username_suffix)
  enterprise.save!
end

When(/^I create an Enterprise with name "([^"]*)" and username suffix "([^"]*)"$/) do |name, username_suffix|
  visit path_to 'new Enterprise'
  fill_in 'name', with: name
  fill_in 'username_suffix', with: username_suffix
  click_button 'Create'
end
