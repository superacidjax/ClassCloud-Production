require 'test_helper'

class WriteboardTest < ActiveSupport::TestCase
 test "should title and body not null" do
   writeboard = Writeboard.new
   assert_equal false, writeboard.save
 end
 test "display first name of first writeboard" do
  writeboard = Writeboard.first.user_id
  first_name = User.find(writeboard).first_name
  assert_equal 'indra', first_name
  end
end
