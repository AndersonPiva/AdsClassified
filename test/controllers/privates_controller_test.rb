require 'test_helper'

class PrivatesControllerTest < ActionController::TestCase
  test "should get profile" do
    get :profile
    assert_response :success
  end

end
