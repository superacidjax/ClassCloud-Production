require 'test_helper'

class ClassRoomTest < ActiveSupport::TestCase
<<<<<<< HEAD
  # test "the truth" do
  #   assert true
  # end
=======
 
  test "class room must have user id" do
    class_room = ClassRoom.new
    class_room.name = 'sunda'
    class_room.user_id = 357581546
    assert_equal false, class_room.save
  end

  test "display first name user of this class" do
    class_room = ClassRoom.first.user_id
    first_name = User.find(class_room).first_name
    assert_equal 'indra', first_name
  end
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
end
