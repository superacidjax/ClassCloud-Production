#--
# Copyright (c) 2008 Matson Systems, Inc.
# Released under the BSD license found in the file 
# LICENSE included with this ActivityStreams plug-in.
#++
# Template to generate the ActivityStream Unit Test
require 'test_helper'
class ActivityStreamTest < ActiveSupport::TestCase
  fixtures :activity_streams

  def test_soft_delete_changes_status
    activity_stream = activity_streams(:one)
    activity_stream.soft_destroy

    activity_stream.reload
    assert_equal activity_stream.status, ActivityStream::DELETED
  end

  def test_object_name
    activity_stream = activity_streams(:one)
    assert_equal activity_stream.object_name_method, 'title'
    assert_equal activity_stream.object_type, 'Assignment'
  end

  def test_actor_name
    activity_stream = activity_streams(:one)
    assert_equal activity_stream.actor_name, 'david andromeda'
  end

  # Note the integration test will test the interaction between 
  # activity_streams and activity_stream_preferences


  def test_find_identical_finds_identical
    activity_stream = ActivityStream.new
    activity_stream.actor_id = 127326141
    activity_stream.actor_type= 'User'
    activity_stream.object_id= '1'
    activity_stream.object_type= 'User'
    activity_stream.verb= 'is_friends_with'
    activity_stream.activity= 'friends'
    activity_stream.object_name_method= 'title'
    activity_stream.actor_name_method= 'full_name'
    activity_stream.status= 0
    activity_stream.save!

    as = ActivityStream.find_identical(User.find(127326141), User.find(563825498),
      :is_friends_with, :friends)

    assert_equal 0, activity_streams.size
  end

  def test_find_identical_finds_nothing
    activity_stream = ActivityStream.new
    activity_stream.actor_id = 1
    activity_stream.actor_type= 'User'
    activity_stream.object_id= '2'
    activity_stream.object_type= 'User'
    activity_stream.verb= 'is_friends_with'
    activity_stream.activity= 'friends'
    activity_stream.object_name_method= 'friendly_name'
    activity_stream.actor_name_method= 'friendly_name'
    activity_stream.status= 0
    activity_stream.save!

    as = ActivityStream.find_identical(User.find('127326141'), User.find('563825498'),
      :is_no_longer_friends_with, :friends)

    assert_nil as
  end

end
