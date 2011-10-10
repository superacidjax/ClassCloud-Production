require 'test_helper'

class AssignmentCategoryTest < ActiveSupport::TestCase
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
end
