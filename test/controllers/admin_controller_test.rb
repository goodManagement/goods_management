require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get admin_edit_url
    assert_response :success
  end

end
