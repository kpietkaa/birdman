var initialize_calendar;
initialize_calendar = function() {
  $('.calendar').each(function(){
    var calendar = $(this);
    calendar.fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },
      selectable: true,
      selectHelper: true,
      editable: true,
      eventLimit: true,
      events: '/events.json',

      // Create event
      select: function(start, end) {
        $.getScript('events/new', function() {
          $('#event_date_range').val(moment(start).format("YYYY/MM/DD HH:mm") + ' - ' + moment(end).format("YYYY/MM/DD HH:mm"))
        });

        calendar.fullCalendar('unselect');
      },

      eventDrop: function(event, delta, revertFunc) {
        event_data = {
          event: {
            id: event.id,
            start_at: event.start.format(),
            end_at: event.end.format()
          }
        };
        $.ajax({
            url: event.update_url,
            data: event_data,
            type: 'PATCH'
        });
      }


    });
  })
};
$(document).on('turbolinks:load', initialize_calendar);
