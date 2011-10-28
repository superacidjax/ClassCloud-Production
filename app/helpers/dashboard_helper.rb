module DashboardHelper
  def month_link(month_date)
    link_to(I18n.localize(month_date, :format => "%B"), {:month => month_date.month, :year => month_date.year})
  end

  def event_calendar_opts
    {
      :year => @year,
      :month => @month,
      :event_strips => @event_strips,
      :month_name_text => I18n.localize(@shown_month, :format => "%B %Y"),
      :previous_month_text =>  "<-" + month_link(Time.now),
      :next_month_text => month_link(Time.now.next_month)+"->" ,
      :width => 640,
      :height => 350
    }
  end

  def user_event
    calendar event_calendar_opts do |args|
      event = args[:event]
      if event.assignment_id.nil? && event.meeting_room_id.nil?
          %(<a href="/events/#{event.id}" title="#{h(event.name)}">#{h(event.name)}</a>)
      elsif event.assignment_id.nil? && !event.meeting_room_id.nil?
          %(<a href="/meeting_rooms/#{event.meeting_room_id}" title="#{h(event.name)}">#{h(event.name)}</a>)
      else
        if current_user.is_teacher?
          %(<a href="/class_rooms/#{event.class_room_id}/assignments/#{event.assignment_id}/comment_new/" title="#{h(event.name)}">#{h(event.name)}</a>)
        elsif current_user.is_student? && !event.assignment.assignment_students.where("user_id =?",current_user.id).first.nil?
          class_room_student = ClassRoomStudent.where("user_id =?",current_user.id).first
          "<a href='/class_rooms/#{class_room_student.class_room_id}/assignments/#{event.assignment_id}/comment_new/' title='#{h(event.name)}'>#{h(event.name)}</a>"
        else
          ""
        end
      end
    end
  end
end
