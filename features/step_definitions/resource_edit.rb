## Attributes

When(/^he changes the "([^"]*)" field to "([^"]*)"$/) do |field, value|
  fill_in field, with: value
end

When(/^he changes the "([^"]*)" select to "([^"]*)"$/) do |field, value|
  select value, from: field
end

## Buttons

When(/^he presses "([^"]*)"$/) do |arg|
  click_button arg
end

When(/^he saves$/) do
  click_button I18n.t(:save)
end

## Comment
When(/^he (un)?marks the Comment as a solution$/) do |un|
  visit path_to('ProblemThread main')
  click_button I18n.t(un ? :solution_unmark : :solution_mark)
end

When(/^he updates the (AdviceThread|ProblemThread) Comment( writing too much)?$/) do |type, long_winded|
  visit path_to "edit #{type} Comment"
  fill_in 'content', with: (long_winded ? 'a' * 300 : "New #{type} Comment content")
  click_button I18n.t(:save)
end

## Facebook

When(/^he connects his account to Facebook$/) do
  visit settings_path_to @consumer
  find_link(I18n.t(:connect, scope: :facebook)).click
end

When(/^he disconnects his account from Facebook$/) do
  visit settings_path_to(@current_user)
  find_link(I18n.t(:disconnect, scope: :facebook)).click
end

## State

When(/^he deletes the( second)? (Enterprise|Product)$/) do |sec, res|
  klass = "#{'second_' if sec}#{res.downcase}"
  visit settings_path_to(instance_variable_get("@#{klass}"))
  click_button I18n.t(:delete)
  click_button I18n.t(:confirm)
end

When(/^he deletes ((his)|the (.*)) account$/) do |usr|
  if usr == 'his'
    visit settings_path_to(@current_user)
  else
    visit settings_path_to(instance_variable_get("@#{usr.parameterize.underscore}"))
  end
  click_button I18n.t(:delete)
  click_button I18n.t(:confirm)
end

When(/^he restores the( second)? (Enterprise|Product)$/) do |sec, res|
  klass = "#{'second_' if sec}#{res.downcase}"
  visit settings_path_to(instance_variable_get("@#{klass}"))
  click_button I18n.t(:restore)
end

When(/^he (un)?locks ((his)|the (.*)) account$/) do |un, usr|
  if usr == 'his'
    visit settings_path_to(@current_user)
  else
    visit settings_path_to(instance_variable_get("@#{usr.parameterize.underscore}"))
  end
  click_button I18n.t(un ? :unlock : :lock)
end
