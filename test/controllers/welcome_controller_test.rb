require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get consumer" do
    get welcome_consumer_url
    assert_response :success
  end

  test "should get enterprise" do
    get welcome_enterprise_url
    assert_response :success
  end

end
