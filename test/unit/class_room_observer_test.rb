require 'test_helper'

class ClassRoomObserverTest < ActiveSupport::TestCase
<<<<<<< HEAD
  # test "the truth" do
  #   assert true
  # end
=======
  test "dislpay first name of first observer in this class" do
    observer = ClassRoomObserver.first.user_id
    first_name = User.find(observer).first_name
    assert_equal 'ahmad', first_name
  end
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
end
