require 'test_helper'

class MapControllerTest < ActionController::TestCase
  test "should get map_view" do
    get :map_view
    assert_response :success
  end

end
