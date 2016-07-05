require 'test_helper'

class FavouritesControllerTest < ActionController::TestCase
  test "should get favourite" do
    get :favourite
    assert_response :success
  end

end
