date_format = event.all_day_event? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'

json.id event.id
json.start event.start_at.strftime(date_format)
json.end event.end_at.strftime(date_format)

json.color event.event_type unless event.event_type.blank?
json.allDay event.all_day_event? ? true : false

json.update_url event_path(event, method: :patch)
json.edit_url edit_event_path(event)
