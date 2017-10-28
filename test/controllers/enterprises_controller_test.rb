require 'test_helper'

class EnterprisesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get enterprises_show_url
    assert_response :success
  end

  test "should get new" do
    get enterprises_new_url
    assert_response :success
  end

end
