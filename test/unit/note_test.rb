require 'test_helper'

class NoteTest < ActiveSupport::TestCase
<<<<<<< HEAD
<<<<<<< HEAD
  # test "the truth" do
  #   assert true
  # end
=======
  test "should title, description, user_id and class_room_id not null" do
    note = Note.new
    assert_equal false, note.save
  end

  test "title must uniqueness" do
    note = Note.new
    note.title = 'hello'
    note.description = 'hello hello!!'
    note.user_id = '563825498'
    assert_equal false, note.save
  end

  test "display first name of first note" do
    note = Note.first.user_id
    first_name = User.find(note).first_name
    assert_equal 'indra', first_name
  end
  
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
  # test "the truth" do
  #   assert true
  # end
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
end
