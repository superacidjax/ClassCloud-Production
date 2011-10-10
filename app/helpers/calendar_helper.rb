module CalendarHelper
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
      :next_month_text => month_link(@shown_month.next_month) + " ->",
      :width => 640    }
  end

  def event_calendar(user_id=nil, teacher=false)
    # args is an argument hash containing :event, :day, and :options
    calendar event_calendar_opts do |args|
      event = args[:event]
      if user_id.blank?
        %(<a href="/events/#{event.id}" title="#{h(event.name)}">#{h(event.name)}</a>)
      else
        unless teacher
          %(<a href="/events/#{event.id}/student/#{user_id}" title="#{h(event.name)}">#{h(event.name)}</a>)
        else
          %(<a href="/events/#{event.id}/teacher/#{user_id}" title="#{h(event.name)}">#{h(event.name)}</a>)
        end
      end
    end
  end
end
