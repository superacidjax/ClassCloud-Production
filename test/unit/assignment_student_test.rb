require 'test_helper'

class AssignmentStudentTest < ActiveSupport::TestCase
<<<<<<< HEAD
  # test "the truth" do
  #   assert true
  # end
=======

  test "should assignment student not null" do
    assignment_student = AssignmentStudent.count
    assert_equal assignment_student, 2
  end

  test "display full name assignment student" do
    assignment_student = AssignmentStudent.first.user_id
    assert_equal User.find(assignment_student).first_name, 'david'
  end
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
end
