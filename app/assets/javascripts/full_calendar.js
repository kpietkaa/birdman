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
      }


    });
  })
};
$(document).on('turbolinks:load', initialize_calendar);
