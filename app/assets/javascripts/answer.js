$(document).ready(function() {
  $('#new_answer').on('submit', function(event) {
    event.preventDefault();
    console.log("ajax working");

    $.ajax({
      method: 'POST',
      url: event.target.action,
      data: $(event.target).serialize()
    }).done(function(data) {
      console.log("werks");

    })
  })
})