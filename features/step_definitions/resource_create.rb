Given(/^an?( second| inactive)? (Enterprise|Product|ProblemThread|AdviceThread)$/) do |sec, res|
  klass = res.underscore
  instance_variable_set("@#{klass}", FactoryBot.create("#{'second_' if sec == ' second'}#{klass}"))
  instance_variable_get("@#{klass}").update(active: false) if sec == ' inactive'
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

## Problem Thread

When(/^he creates a new (Advice|Problem) Thread( with a too long (title|content))?$/) do |type, field|
  @product = FactoryBot.create(:product)
  FactoryBot.create(:problem_operator) if type == 'Problem'
  visit path_to("new #{type}Thread")
  fill_in 'content', with: (field == 'content' ? 'a' * 300 : "#{type} Thread content")
  fill_in 'title', with: (field == 'title' ? 'a' * 300 : "#{type} Thread title")
  click_button I18n.t(:create)
end

## Relationship

When(/^he creates a new Problem Thread Relationship$/) do
  visit path_to('new ProblemThreadRelationship')
end

When(/^he creates a new Advice Thread Relationship$/) do
  visit path_to('new AdviceThreadRelationship')
end
