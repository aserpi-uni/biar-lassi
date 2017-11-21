## Normal pages

Given(/^he is on the "([^"]*)" page$/) do |arg|
  visit path_to(arg)
end


## Settings page

Given(/^he is on his settings page$/) do
  visit settings_path_to @current_user
end

Given(/^he is on the (.*)'s settings page$/) do |klass|
  visit settings_path_to instance_variable_get "@#{klass.parameterize.underscore}"
end
