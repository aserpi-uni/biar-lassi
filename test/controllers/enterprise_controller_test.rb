require 'test_helper'

class EnterpriseControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get enterprise_show_url
    assert_response :success
  end

  test "should get new" do
    get enterprise_new_url
    assert_response :success
  end

  test "should get create" do
    get enterprise_create_url
    assert_response :success
  end

end
