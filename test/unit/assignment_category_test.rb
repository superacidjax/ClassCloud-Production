require 'test_helper'

class AssignmentCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should assignment category not null" do
    assignment_category = AssignmentCategory.count
    assert_equal assignment_category,3
  end
  # test "the truth" do
  #   assert true
  # end
end
