require 'test_helper'

class ToDoTest < ActiveSupport::TestCase
<<<<<<< HEAD
  # test "the truth" do
  #   assert true
  # end
=======
  test "the size of time type" do
    assert_equal 6, ToDo::TIME_TYPE.size
  end
  
  test "should not save invalid todo" do
    todo = ToDo.new
    assert_equal false, todo.save
    assert_equal 4, ToDo.count
  end

  test "should save valid todo" do
    todo = ToDo.new(title: "ToDo6", description: "blablabla...", user_id: 1, date: Time.now.to_s(:db))
    assert_equal true, todo.save
    assert_equal 5, ToDo.count
    assert_equal "ToDo5", ToDo.last.title
  end
  
  test "should current user id  equal with todo user_id is" do
    todo = ToDo.first
    assert_equal 624604774, todo.id
  end

  test "todo attributes must not be empty" do
    todo = ToDo.new
    assert todo.invalid?
    assert todo.errors[:title].any?
    assert todo.errors[:description].any?
    assert todo.errors[:date].any?
  end

  test "displayed first todo id which equal with current user id" do
    todo = ToDo.where("user_id =?",357581546).first
    assert_equal 357581546,todo.user_id
  end

  
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
end
