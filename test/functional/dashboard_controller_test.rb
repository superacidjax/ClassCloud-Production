require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
  tests DashboardControllerTest
  include Devise::TestHelpers

  test "should get index" do
    get :index
    assert_response :success
  end

end
