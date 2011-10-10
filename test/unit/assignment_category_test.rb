require 'test_helper'

class AssignmentCategoryTest < ActiveSupport::TestCase
<<<<<<< HEAD
<<<<<<< HEAD
  # test "the truth" do
  #   assert true
  # end
=======
  test "should assignment category not null" do
    assignment_category = AssignmentCategory.count
    assert_equal assignment_category,3
  end
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
  # test "the truth" do
  #   assert true
  # end
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
end
