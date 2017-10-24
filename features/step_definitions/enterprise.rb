Given(/^I created an Enterprise with name "([^"]*)" and nickname suffix "([^"]*)"$/) do |name, nickname_suffix|
  enterprise = Enterprise.new(name: name, nickname_suffix: nickname_suffix)
  enterprise.save!
end

When(/^I create an Enterprise with name "([^"]*)" and nickname suffix "([^"]*)"$/) do |name, nickname_suffix|
  visit path_to 'new Enterprise'
  fill_in 'enterprise[name]', with: name
  fill_in 'enterprise[nickname_suffix]', with: nickname_suffix
  click_button 'Create Enterprise'
end
