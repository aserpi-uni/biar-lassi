Given(/^an? (ProblemThreadCommentE|ProblemThreadCommentC|AdviceThreadCommentE|AdviceThreadCommentC)$/) do |res|
  klass = res.underscore
  instance_variable_set("@#{klass}", FactoryBot.create("#{klass}"))
end

## Problem Thread Comment Employee

When(/^he creates a new ProblemThreadCommentE( with a too long content)?$/) do |field|
  visit path_to('new ProblemThreadCommentE')
  if field
    fill_in 'content', with: 'a'*300
  else
    fill_in 'content', with: 'Problem thread comment content by employee'
  end
  click_button I18n.t(:create)
end

## Problem Thread Comment Consumer

When(/^he creates a new ProblemThreadCommentC( with a too long content)?$/) do |field|
  visit path_to('new ProblemThreadCommentC')
  if field
    fill_in 'content', with: 'a'*300
  else
    fill_in 'content', with: 'Problem thread comment content by consumer'
  end
  click_button I18n.t(:create)
end

## Advice Thread Comment Employee

When(/^he creates a new AdviceThreadCommentE( with a too long content)?$/) do |field|
  visit path_to('new AdviceThreadCommentE')
  if field
    fill_in 'content', with: 'a'*300
  else
    fill_in 'content', with: 'Advice thread comment content by employee'
  end
  click_button I18n.t(:create)
end

## Advice Thread Comment Employee

When(/^he creates a new AdviceThreadCommentC( with a too long content)?$/) do |field|
  visit path_to('new AdviceThreadCommentC')
  if field
    fill_in 'content', with: 'a'*300
  else
    fill_in 'content', with: 'Advice thread comment content by consumer'
  end
  click_button I18n.t(:create)
end