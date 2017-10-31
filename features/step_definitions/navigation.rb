Given(/^I am on the "([^"]*)" page$/) do |arg|
  visit path_to(arg)
end

Given(/^I am on the "edit" page for (Admin|Employee|Enterprise) "([^"]*)"$/) do |resource, name|
  visit path_to("edit #{resource} \"#{name}\"")
end

When(/^I click on the "([^"]*)" link$/) do |arg|
  find(:xpath, "//a[@href=\"#{arg}\"]").click
end
