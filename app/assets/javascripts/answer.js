$(document).ready(function() {
  $('#new_answer').on('submit', function(event) {
    event.preventDefault();
    console.log("ajax working");

    $.ajax({
      method: 'POST',
      url: event.target.action,
      data: $(event.target).serialize()
    }).done(function(data) {
      $(".new_answer_holder").append(data);
    }).fail(function(){
      console.log("ajax failed");
    })
  })
})