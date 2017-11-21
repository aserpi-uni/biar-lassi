## Enterprise

Given(/^an?( second)? Enterprise$/) do |sec|
  @enterprise = FactoryBot.create "#{'second_' if sec}enterprise"
end

When(/^(he|the Admin) creates a new Enterprise( with a (.*) already taken)?$/) do |useless, field|
  visit path_to('new Enterprise')
  fill_in 'name', with: 'Enterprise_two'
  fill_in 'username_suffix', with: 'enter_two'
  if field
    field = field.parameterize.underscore
    fill_in field, with: @enterprise.send(field)
  end
  click_button I18n.t(:create)
end
