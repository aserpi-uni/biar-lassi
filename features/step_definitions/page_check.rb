Given(/^I am on the "([^"]*)" page$/) do |arg|
  visit path_to(arg)
end

Then(/^I should( not)? see a "([^"]*)" input field$/) do |absent, field|
  assert(page.has_css?("label[for=\"#{field}\"]") == absent.blank?)
end

Then(/^I should( not)? see a "([^"]*)" link$/) do |absent, field|
  assert(page.has_css?("a[href=\"#{field}\"]") == absent.blank?)
end

Then(/^I should( not)? see a "([^"]*)" text$/) do |absent, field|
  assert(page.has_text?(field) == absent.blank?)
end
