require 'test_helper'

class ClassRoomTest < ActiveSupport::TestCase
  test "class room must have user id" do
    class_room = ClassRoom.new
    class_room.name = 'sunda'
    assert_equal false, class_room.save
  end

  test "display first name user of this class" do
    class_room = ClassRoom.first.user_id
    first_name = User.find(class_room).first_name
    assert_equal 'indra', first_name
  end
end
