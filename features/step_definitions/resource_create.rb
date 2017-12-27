Given(/^an?( second)? (Enterprise|Product)$/) do |sec, res|
  klass = res.downcase
  instance_variable_set("@#{klass}", FactoryBot.create("#{'second_' if sec}#{klass}"))
end

## Enterprise

When(/^(he|the Admin) creates a new Enterprise( with a (.*) already taken)?$/) do |_useless, field|
  visit path_to('new Enterprise')
  fill_in 'name', with: 'Enterprise_two'
  fill_in 'username_suffix', with: 'enter_two'
  if field
    field = field.parameterize.underscore
    fill_in field, with: @enterprise.send(field)
  end
  click_button I18n.t(:create)
end

## Product

When(/^he creates a new Product( with a model already taken)?$/) do |field|
  visit path_to('new Product')
  fill_in 'model', with: field ? @product.send('model') : 'Model_two'
  click_button I18n.t(:create)
end
