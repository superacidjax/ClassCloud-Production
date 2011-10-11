require 'test_helper'

class DiscussionTest < ActiveSupport::TestCase
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
end
