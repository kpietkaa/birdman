json.array! @events do |event|
  date_format = event.all_day_event? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'
  json.id event.id
  if event.user_id == current_user.id || current_user.role == 'admin' || event.doctor_id == current_user.id
    json.title VisitType.all.select{ |v| event.event_type == v.color }.map{ |v| [v.title] }
    json.color event.event_type
  else
    json.title 'Appointment'
    json.color 'Grey'
  end
  json.start event.start_at.strftime(date_format)
  json.end event.end_at.strftime(date_format)
  json.allDay event.all_day_event? ? true : false
  json.update_url event_path(event, method: :patch)
  json.edit_url edit_event_path(event)
end
