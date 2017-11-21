## Errors

When(/^an? (Admin|Consumer|Employee) logs in with a nonexistent account$/) do |klass|
  manual_login klass, 'nonexistent', 'password'
end

When(/^the (Admin|Consumer|Employee) logs in with incorrect credentials$/) do |klass|
  manual_login klass, instance_variable_get("@#{klass.downcase}").username, 'wrong_password'
end

## Facebook

When(/^a Consumer logs in with Facebook choosing a taken username$/) do
  @consumer = FactoryBot.create(:consumer)
  visit path_to 'Consumer sign in'
  find(:xpath, '//a[@href="/auth/consumers/auth/facebook"]').click

  fill_in 'username_select', with: @consumer.username
  fill_in 'password_select', with: 'password'
  fill_in 'password_confirmation_select', with: 'password'
  click_button I18n.t(:sign_up)
end

When(/^(a Consumer|he) logs in with Facebook( with no email)?( registering a username)?( and an email)?$/) do |_useless, null_email, username, email|
  OmniAuth.config.add_mock :facebook, info: { email: '' } if null_email
  visit path_to 'Consumer sign in'
  find(:xpath, '//a[@href="/auth/consumers/auth/facebook"]').click
  @current_user = Consumer.new

  if username
    fill_in 'username_select', with: 'facebook_manual'
    fill_in 'password_select', with: 'password'
    fill_in 'password_confirmation_select', with: 'password'
    fill_in 'email_select', with: 'facebook@example.com' if email
    click_button I18n.t(:sign_up)
    @current_user = Consumer.find_by(username: 'facebook_manual')
  end
end

When(/^he connects to a pre-existent account( with incorrect credentials)?$/) do |wrong|
  fill_in 'username_sign_in', with: @consumer.username
  fill_in 'password_sign_in', with: (wrong ? 'wrong_password' : 'password')
  click_button I18n.t(:sign_in)
end

## Success

Given(/^an? (Admin|Consumer|Employee|Operator|Supervisor) is logged in$/) do |klass|
  klass = klass.downcase
  @current_user = instance_variable_set("@#{klass}", FactoryBot.create(klass))
  instance_variable_get("@#{klass}").update(confirmed_at: Time.now) if klass == 'consumer'
  instance_variable_set('@enterprise', instance_variable_get("@#{klass}").enterprise) if employee? klass
  login_as @current_user, scope: (employee?(klass) ? :employee : klass)
end

When(/^the (Admin|Consumer|Employee|Operator|Supervisor) logs in$/) do |klass|
  @current_user = instance_variable_get("@#{klass.downcase}")
  manual_login klass, @current_user.username, 'password'
end

When(/^he signs out$/) do
  logout
end

private

def manual_login(klass, username, password)
  visit path_to("#{klass} sign in")
  fill_in 'username', with: username
  fill_in 'password', with: password
  click_button 'Login'
end
