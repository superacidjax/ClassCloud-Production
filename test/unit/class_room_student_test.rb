require 'test_helper'

class ClassRoomStudentTest < ActiveSupport::TestCase
  test "display first name of first class room student" do
    class_room = ClassRoomStudent.first.user_id
    first_name = User.find(class_room).first_name
    assert_equal 'indra', first_name
  end
end
