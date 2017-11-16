require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "new" do
    mail = UserMailer.new
    assert_equal "New", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
