When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in field, with: value
end

When(/^I press "([^"]*)"$/) do |arg|
  click_button arg
end

When(/^I press "([^"]*)" in "([^"]*)" with "([^"]*)" as "([^"]*)"$/) do |button, scope, prop, prop_value|
  within(:css, "#{scope}[#{prop}=\"#{prop_value}\"]") do
    click_button button
  end
end


When(/^I fill in "([^"]*)" \(in "([^"]*)" with "([^"]*)" as "([^"]*)"\) with "([^"]*)"$/) do |field, scope, prop, prop_value, field_value|
  within(:css, "#{scope}[#{prop}=\"#{prop_value}\"]") do
    fill_in field, with: field_value
  end
end
