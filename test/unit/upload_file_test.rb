require 'test_helper'

class UploadFileTest < ActiveSupport::TestCase
  test "should title and file not null" do
    file = UploadFile.new
    assert_equal false, file.save
  end
  test "display first name of first Uploaded file" do
    file = UploadFile.first.user_id
    first_name = User.find(file).first_name
    assert_equal 'indra', first_name

  end
end
