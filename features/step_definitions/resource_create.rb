Given(/^an?( second)? (Enterprise|Product|ProblemThread|AdviceThread)$/) do |sec, res|
  klass = res.underscore
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

## Problem Thread

When(/^he creates a new Problem Thread( with a too long( title| content))?$/) do |field|
  visit path_to('new ProblemThread')
  if field
    if field == ' title'
      fill_in 'title', with: 'a'*300
      fill_in 'content', with: 'problem thread Content'
    elsif field == ' content'
      fill_in 'title', with: 'problem thread Title'
      fill_in 'content', with: 'a'*300
    end
  else
    fill_in 'title', with: 'problem thread Title'
    fill_in 'content', with: 'problem thread Content'
  end
  click_button I18n.t(:create)
end

## Advice Thread

When(/^he creates a new Advice Thread( with a too long( title| content))?$/) do |field|
  visit path_to('new AdviceThread')
  if field
    if field == ' title'
      fill_in 'title', with: 'a'*300
      fill_in 'content', with: 'advice thread Content'
    elsif field == ' content'
      fill_in 'title', with: 'advice thread Title'
      fill_in 'content', with: 'a'*300
    end
  else
    fill_in 'title', with: 'advice thread Title'
    fill_in 'content', with: 'advice thread Content'
  end

  click_button I18n.t(:create)
end

## Relationship

When(/^he creates a new Problem Thread Relationship$/) do
  visit path_to('new ProblemThreadRelationship')
end

When(/^he creates a new Advice Thread Relationship$/) do
  visit path_to('new AdviceThreadRelationship')
end

