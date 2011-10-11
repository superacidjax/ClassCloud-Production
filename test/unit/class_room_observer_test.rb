require 'test_helper'

class ClassRoomObserverTest < ActiveSupport::TestCase
  test "dislpay first name of first observer in this class" do
    observer = ClassRoomObserver.first.user_id
    first_name = User.find(observer).first_name
    assert_equal 'ahmad', first_name
  end
end
