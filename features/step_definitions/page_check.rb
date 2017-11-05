Then(/^I should( not)? see a "([^"]*)" input field( with value "([^*]*)")?$/) do |absent, field, value|
  if value
    assert(page.has_css?("input[id=\"#{field}\"][value=\"#{value}\"]") == absent.blank?)
  else
    assert(page.has_css?("input[id=\"#{field}\"]") == absent.blank?)
  end
end

Then(/^I should( not)? see a "([^"]*)" link$/) do |absent, field|
  assert(page.has_css?("a[href=\"#{field}\"]") == absent.blank?)
end

Then(/^I should( not)? see a "([^"]*)" text$/) do |absent, field|
  assert(page.has_text?(field) == absent.blank?)
end

Then(/^I should( not)? see a "([^"]*)" title$/) do |absent, field|
  assert(page.has_title?(field) == absent.blank?)
end

When(/^I save the current page$/) do
  save_page
end
