require 'test_helper'

class ClassRoomObserverTest < ActiveSupport::TestCase
<<<<<<< HEAD
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
=======
  # test "the truth" do
  #   assert true
  # end
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
end
