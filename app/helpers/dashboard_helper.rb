module DashboardHelper
  def month_link(month_date)
    link_to(I18n.localize(month_date, :format => "%B"), {:month => month_date.month, :year => month_date.year})
  end

  # custom options for this calendar
  def event_calendar_opts
    {
      :year => @year,
      :month => @month,
      :event_strips => @event_strips,
      :month_name_text => I18n.localize(@shown_month, :format => "%B %Y"),
      :previous_month_text => "<- " + month_link(@shown_month.prev_month),
      :next_month_text => month_link(Time.now.next_month) + " ->",
      :width => 640,
      :height => 350
    }
  end

  def user_event
    require 'pp'
    calendar event_calendar_opts do |args|      
    #  pp args
      event = args[:event]
      if event.assignment_id.nil?
        %(<a href="/events/#{event.id}" title="#{h(event.name)}">#{h(event.name)}</a>)
      else
        if current_user.is_teacher?          
          current_user.class_rooms.each do |class_room|
            %(<a href="/class_rooms/#{class_room.id}/assignments/" title="#{h(event.name)}">#{h(event.name)}</a>)
          end
        elsif current_user.is_student? &&  !event.assignment.assignment_students.where("user_id =?",current_user.id).first.nil?
          #          debuggassignment = Assignment.find(event.assignment_id)
#                  assignment_student = assignment.assignment_students.where("user_id =?",current_user.id)
          #          if assignment_student.id.eql?(current_user.id)
          #          current_user.class_room_students.each do |class_room_student|
#          event.assignment.assignment_students.where("user_id =?",current_user.id)
            class_room_student = ClassRoomStudent.where("user_id =?",current_user.id).first
            "<a href='/class_rooms/#{class_room_student.class_room_id}/assignments/' title='#{h(event.name)}'>#{h(event.name)}</a>"
        else
          pp "1111111111111111111111"
          pp current_user.is_student? &&  !event.assignment.assignment_students.where("user_id =?",current_user.id).first.nil?
          pp "22222222222222222222222222"
          pp current_user.is_student?
          pp "3333333333333333333333333333"
          pp event.assignment.assignment_students.where("user_id =?",current_user.id).first
          ""
        end
      end
    end
  end
end
