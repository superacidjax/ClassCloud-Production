require 'test_helper'

class UserMeetingRoomsControllerTest < ActionController::TestCase
  setup do
    @user_meeting_room = user_meeting_rooms(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_meeting_rooms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_meeting_room" do
    assert_difference('UserMeetingRoom.count') do
      post :create, user_meeting_room: @user_meeting_room.attributes
    end

    assert_redirected_to user_meeting_room_path(assigns(:user_meeting_room))
  end

  test "should show user_meeting_room" do
    get :show, id: @user_meeting_room.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_meeting_room.to_param
    assert_response :success
  end

  test "should update user_meeting_room" do
    put :update, id: @user_meeting_room.to_param, user_meeting_room: @user_meeting_room.attributes
    assert_redirected_to user_meeting_room_path(assigns(:user_meeting_room))
  end

  test "should destroy user_meeting_room" do
    assert_difference('UserMeetingRoom.count', -1) do
      delete :destroy, id: @user_meeting_room.to_param
    end

    assert_redirected_to user_meeting_rooms_path
  end
end
