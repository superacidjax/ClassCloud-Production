require 'test_helper'

class UploadFileTest < ActiveSupport::TestCase
<<<<<<< HEAD
<<<<<<< HEAD
  # test "the truth" do
  #   assert true
  # end
=======
  test "should title and file not null" do
    file = UploadFile.new
    assert_equal false, file.save
  end
  test "display first name of first Uploaded file" do
    file = UploadFile.first.user_id
    first_name = User.find(file).first_name
    assert_equal 'indra', first_name

  end
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
  # test "the truth" do
  #   assert true
  # end
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
end
