module ApplicationHelper
  
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
  
  def created_at(date)
    date.strftime('%b %d %Y, %H:%M')
  end

  def date_format(date)
    date.strftime('%b %d %Y, %H:%M')
  end
  
  def file(x)
    MessageFile.where("message_id=?",x).last
  end

  def link_to_feed(class_id,object_type,object_id,verb)  
    if verb.eql?('commented')
      "/class_rooms/#{class_id}/#{object_type.downcase.pluralize}/#{object_id}/comment_new"
    elsif verb.eql?('completed')
      "/class_rooms/#{class_id}/assignments/#{object_id}/comment_new"
    else
      "/class_rooms/#{class_id}/#{object_type.downcase.pluralize}/#{object_id}"
    end
  end

<<<<<<< HEAD
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
=======
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

>>>>>>> 06aff02a73ca1ec4a4ed69921c1971e6036684de
end