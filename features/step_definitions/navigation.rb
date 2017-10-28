Given(/^I am on the "([^"]*)" page$/) do |arg|
  visit path_to(arg)
end


When(/^I click on the "([^"]*)" link$/) do |arg|
  find(:xpath, "//a[@href=\"#{arg}\"]").click
end
