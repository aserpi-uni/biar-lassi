When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |arg1, arg2|
  fill_in arg1, with: arg2
end

When(/^I press "([^"]*)"$/) do |arg|
  click_button arg
end
