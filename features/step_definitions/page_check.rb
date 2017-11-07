Then(/^save page$/) do
  save_page
end

Then(/^he should( not)? see a "([^"]*)" input field( with value "([^*]*)")?$/) do |absent, field, value|
  if value
    assert(page.has_css?("input[id=\"#{field}\"][value=\"#{value}\"]") == absent.blank?)
  else
    assert(page.has_css?("input[id=\"#{field}\"]") == absent.blank?)
  end
end

Then(/^he should( not)? see a "([^"]*)" link$/) do |absent, field|
  assert(page.has_css?("a[href=\"#{path_to field}\"]") == absent.blank?)
end

Then(/^he should( not)? see a "([^"]*)" text$/) do |absent, string|
  assert(page.has_text?(string) == absent.blank?)
end
