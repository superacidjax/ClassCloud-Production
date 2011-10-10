#--
# Copyright (c) 2008 Matson Systems, Inc.
# Released under the BSD license found in the file 
# LICENSE included with this ActivityStreams plug-in.
#++
# Template to generate the ActivityStream Unit Test
<<<<<<< HEAD
<<<<<<< HEAD
require File.dirname(__FILE__) + '/../test_helper'
=======
require 'test_helper'
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
require File.dirname(__FILE__) + '/../test_helper'
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
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

<<<<<<< HEAD
<<<<<<< HEAD
    assert_equal activity_stream.object_name, 'test_torrent'
=======
    assert_equal activity_stream.object_name_method, 'title'
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
    assert_equal activity_stream.object_name, 'test_torrent'
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  end

  def test_actor_name
    activity_stream = activity_streams(:one)

<<<<<<< HEAD
<<<<<<< HEAD
    assert_equal activity_stream.actor_name, 'aaron'
=======
    assert_equal activity_stream.actor_name, 'david'
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
    assert_equal activity_stream.actor_name, 'aaron'
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  end

  # Note the integration test will test the interaction between 
  # activity_streams and activity_stream_preferences
  def test_recent_actors
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
    activity_streams = ActivityStream.recent_actors(users(:aaron), 
      :public_location, 5)
    assert_equal 5, activity_streams.size
  end

  def test_recent_objects
    activity_streams = ActivityStream.recent_objects(torrents(:test_torrent), 
      :public_location, 5)
    assert_equal 5, activity_streams.size
  end

  def test_find_identical_finds_identical
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

    as = ActivityStream.find_identical(User.find(1), User.find(2),
      :is_friends_with, :friends)

    assert_equal as, activity_stream

<<<<<<< HEAD
=======
    activity_streams = ActivityStream.recent_actors(users(:david),
      :public_location, 5)
    assert_equal 1, activity_streams.size
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
  end

  def test_find_identical_finds_nothing
    activity_stream = ActivityStream.new
<<<<<<< HEAD
<<<<<<< HEAD
    activity_stream.actor_id = 1
=======
    activity_stream.actor_id = 127326141
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
    activity_stream.actor_id = 1
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
    activity_stream.actor_type= 'User'
    activity_stream.object_id= '2'
    activity_stream.object_type= 'User'
    activity_stream.verb= 'is_friends_with'
    activity_stream.activity= 'friends'
    activity_stream.object_name_method= 'friendly_name'
    activity_stream.actor_name_method= 'friendly_name'
    activity_stream.status= 0
    activity_stream.save!

<<<<<<< HEAD
<<<<<<< HEAD
    as = ActivityStream.find_identical(User.find(1), User.find(2),
=======
    as = ActivityStream.find_identical(User.find('127326141'), User.find('563825498'),
>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
=======
    as = ActivityStream.find_identical(User.find(1), User.find(2),
>>>>>>> 9e61f9c8bf30a244cc4a2714ffef97145fbd9d36
      :is_no_longer_friends_with, :friends)

    assert_nil as
  end

end
