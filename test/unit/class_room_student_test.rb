require 'test_helper'

class ClassRoomStudentTest < ActiveSupport::TestCase
<<<<<<< HEAD
  # test "the truth" do
  #   assert true
  # end
=======
  test "display first name of first class room student" do
    class_room = ClassRoomStudent.first.user_id
    first_name = User.find(class_room).first_name
    assert_equal 'indra', first_name
  end
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
end
