module ApplicationHelper
  
  def karma_number(student)
    Vote.where("voteable_user_id = ?", student).count
  end

  def my_date_time
    Time.now
  end
  
  def time(x)
    x.to_date.strftime('%b %d %Y, %H:%M')
  end
  
  def first_name(user)
    User.where("id =?",user).first
  end
  
  def content_type(content)
    if  content.file_content_type.eql?('application/pdf')
      image_tag('pdf.jpeg', :height=>'50px;', :width =>'50px;')
    elsif content.file_content_type.eql?('image/png')or content.file_content_type.eql?('image/gif')or content.file_content_type.eql?('image/jpeg')
      image_tag('jpeg-icon.jpeg', :height => '50px;', :width => '50px;')
    elsif content.file_content_type.eql?('application/vnd.openxmlformats-officedocument.wordprocessingml.document')or content.file_content_type.eql?('application/msword')
      image_tag("word.jpeg", :height => '50px;', :width => '50px;')
    elsif content.file_content_type.eql?('application/vnd.ms-excel')
      image_tag('excel.jpeg', :height => '50px;', :width => '50px;')
    elsif content.file_content_type.eql?('application/zip')
      image_tag('zip.jpeg', :height => '50px;', :width => '50px;')
    elsif content.file_content_type.eql?('application/x-rar')
      image_tag('rar.jpeg', :height => '50px;', :width => '50px;')
    elsif content.file_content_type.eql?('text/plain')
      image_tag('text.jpeg', :height => '50px;', :width => '50px;')
    else
      image_tag('unknown.jpeg', :height => '50px;', :width => '50px;')
    end
  end

  def date_format(date)
    date.strftime('%b %d %Y, %H:%M')
  end
  
  def file(x)
    MessageFile.where("message_id=?",x).last
  end

  def link_to_feed(class_id, object_type, object_id, verb, student_id)
    if verb.eql?('commented')
      "/class_rooms/#{class_id}/#{object_type.downcase.pluralize}/#{object_id}/comment_new"
    elsif verb.eql?('completed')
      "/class_rooms/#{class_id}/assignments/#{object_id}/comment_new"
    else
      if current_user.is_obsevers?
        "/class_rooms/#{class_id}/#{object_type.downcase.pluralize}/#{object_id}"
      else
        "/class_rooms/#{class_id}/#{object_type.downcase.pluralize}/#{object_id}/student/#{student_id}"

      end
    end
  end
  
  def vote_count(voteable_id)
    Vote.where("voteable_id =?",voteable_id).count
  end

  def vote_assignment(voteable_id)
    Vote.where("voteable_id =? and voter_id=? and voteable_type=?",voteable_id, current_user.id,'Assignment').first
  end

  def vote_notes(voteable_id)
    Vote.where("voteable_id =? and voter_id=? and voteable_type=?",voteable_id, current_user.id,'Note').first
  end

  def vote_writeboard(voteable_id)
    Vote.where("voteable_id =? and voter_id=? and voteable_type=?",voteable_id, current_user.id,'Writeboard').first
  end
  def vote_comment(voteable_id)
    Vote.where("voteable_id =? and voter_id=? and voteable_type=?",voteable_id, current_user.id,'Comment').first

  end

  def vote_count(voteable_id)
    Vote.where("voteable_id =?",voteable_id).count
  end

  def vote_type(voteable_id)
    Vote.where("voteable_id =? and voter_id=? and voteable_type=?",voteable_id, current_user.id,'Assignment').first
  end

  def vote_notes(voteable_id)
    Vote.where("voteable_id =? and voter_id=? and voteable_type=?",voteable_id, current_user.id,'Note').first
  end

  def vote_writeboard(voteable_id)
    Vote.where("voteable_id =? and voter_id=? and voteable_type=?",voteable_id, current_user.id,'Writeboard').first
  end

  def vote_comment(voteable_id)
    Vote.where("voteable_id =? and voter_id=? and voteable_type=?",voteable_id, current_user.id,'Comment').first
  end
  
  def find_actor(activity_stream)
    object = activity_stream.object_type.constantize.find(activity_stream.object_id)
    actor = activity_stream.actor_type.constantize.find(activity_stream.actor_id)
    return object,actor
  end

  def link_feed_helper(activity_stream,actor, object)
    link_to " #{actor.instance_eval(activity_stream.actor_name_method)}(#{karma_number(@student)}) #{activity_stream.verb.gsub("_", " ")} #{activity_stream.activity} #{object.instance_eval(activity_stream.object_name_method)}",link_to_feed(@my_class_rooms.first.id ,activity_stream.object_type ,activity_stream.object_id , activity_stream.verb.gsub("_", " "),activity_stream.actor_id)
  end

  def deleted_feed(activity_stream,actor)
    if actor.nil?      
      activity_stream.destroy
      return ""
    else
     return " #{date_format(activity_stream.created_at)} #{actor.instance_eval(activity_stream.actor_name_method)} deleted #{activity_stream.activity}"
    end
    
  end

  def date_feed_format(activity_stream,actor)
    "#{date_format(activity_stream.created_at)} #{actor.instance_eval(activity_stream.actor_name_method)}"
  end

  def class_rooms(class_room)
    current_user.class_room_observers.find_all_by_class_room_id(class_room)

  end
end