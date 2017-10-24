When(/^I login as an? (Admin|Consumer|Employee) with username "([^"]*)"$/) do |klass, name|
  visit path_to("#{klass} sign in")
  fill_in 'username', with: name
  fill_in 'password', with: 'password'
  click_button 'Login'
end

When(/^I login with Facebook( with a null email)?( registering the username "([^"]*)")?( and the email "([^"]*)")?$/) do |null_email, username, email|
  OmniAuth.config.add_mock :facebook, info: { email: '' } if null_email
  visit path_to 'Consumer sign in'
  find(:xpath, '//a[@href="/auth/consumers/auth/facebook"]').click

  if username
    within(:css, 'form[action="/auth/consumers/facebook/select_username"]') do
      fill_in 'username_select', with: username
      fill_in 'email_select', with: email if email
      click_button 'Register'
    end
  end
end
