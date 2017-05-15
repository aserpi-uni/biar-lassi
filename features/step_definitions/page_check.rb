Given(/^I am on the "([^"]*)" page$/) do |arg|
  visit path_to(arg)
end

Then(/^I should( not)? see a "([^"]*)" input field$/) do |absent, field|
  page.assert_selector(:css, "label[for=\"#{field}\"]") == absent.blank?
end

Then(/^I should see a "([^"]*)" link$/) do |arg|
  page.assert_selector :css, "a[href=\"#{arg}\"]"
end


Then(/^I should see a "([^"]*)" text$/) do |arg|
  page.has_text? arg
end
