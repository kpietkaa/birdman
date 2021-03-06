var initialize_calendar;
var myDate = new Date();
myDate.setHours(myDate.getHours() + 24);
var myDay = new Date();
myDay.setDate(myDay.getDate());
var current_user_role;
$.get('/current_user_role', function(result){
current_user_role = result.role;
});

initialize_calendar = function() {
  $('.calendar').each(function(){
    var calendar = $(this);
    calendar.fullCalendar({
      header: {
        defaultView: 'agendaWeek',
        left: 'prev,next today',
        center: 'title',
        right: 'agendaWeek,month,agendaDay,list'
      },
      allDaySlot: false,
      weekends: false,
      minTime: '07:00',
      maxTime: '21:00',
      height: 750,
      defaultView: 'agendaWeek',
      selectable: true,
      selectHelper: true,
      editable: true,
      eventLimit: true,
      businessHours: {
        dow: [ 1, 2, 3, 4, 5 ],
        start: '09:00',
        end: '18:00',
      },
      firstDay: 1,
      eventDurationEditable: false,
      eventStartEditable: false,
      events: '/events.json',
      timeFormat: 'HH:mm',


      // Create event
      select: function(start, end) {
        if (current_user_role == 'doctor') {
          $.getScript('events/new', function() {
            $('#event_date_range').val(moment(start).format("YYYY/MM/DD HH:mm") + ' - ' + moment(end).format("YYYY/MM/DD HH:mm"))
          });

          calendar.fullCalendar('unselect');
        }

        if (start < myDay)
        {
          calendar.fullCalendar('unselect');
        }
        else {
          $.getScript('events/new', function() {
            $('#event_date_range').val(moment(start).format("YYYY/MM/DD HH:mm") + ' - ' + moment(end).format("YYYY/MM/DD HH:mm"))
          });

          calendar.fullCalendar('unselect');
        }
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
      },

      eventClick: function(event, jsEvent, view) {
        if (current_user_role == 'doctor') {
          $.getScript(event.edit_url, function() {
            $('#event_date_range').val(moment(event.start).format("YYYY/MM/DD HH:mm") + ' - ' + moment(event.end).format("YYYY/MM/DD HH:mm"))
            date_range_picker();
          });
        }

        if (moment(event.start) < myDate)
        {
          calendar.fullCalendar('unselect');
        }
        else {
          $.getScript(event.edit_url, function() {
            $('#event_date_range').val(moment(event.start).format("YYYY/MM/DD HH:mm") + ' - ' + moment(event.end).format("YYYY/MM/DD HH:mm"))
            date_range_picker();
          });
        }
      }

    });
  })
};
$(document).on('turbolinks:load', initialize_calendar);
