require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
<<<<<<< HEAD
  # test "the truth" do
  #   assert true
  # end
=======
  test "title must be uniqueness" do
    assignment = Assignment.new
    assignment.title = 'assignment1'
    assignment.description = 'hello'
    assignment.user_id = '563825498'
    assert_equal false, assignment.save
  end

  test "should title,description and user_id presence" do
    assignment = Assignment.new
    assert_equal false, assignment.save
  end

  test "display first name of assignment user" do
    assignment = Assignment.first.user_id
    first_name = User.find(assignment).first_name
    assert_equal 'indra', first_name
  end
  
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
end
