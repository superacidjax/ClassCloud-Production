require 'test_helper'

class DiscussionTest < ActiveSupport::TestCase
<<<<<<< HEAD
  # test "the truth" do
  #   assert true
  # end
=======
  test "display first name user of first discussion" do
    discussion = Discussion.first.user_id
    first_name = User.find(discussion).first_name
    assert_equal 'david', first_name
  end

  test "title, description, user_id and class_room_id must not empty" do
    discussion = Discussion.new
    assert_equal false, discussion.save
  end

  test "title must be uniqueness" do
    discussion = Discussion.new
    discussion.title = 'Hello world'
    discussion.description = 'blablabla...'
    discussion.user_id = 127326141
    assert_equal false, discussion.save
  end
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
end
