$(document).ready(function() {
  $('#new_answer').on('submit', function(event) {
    event.preventDefault();
    // console.log("ajax working");

    $.ajax({
      method: 'POST',
      url: event.target.action,
      data: $(event.target).serialize(),
      dataType: 'json'
    }).done(function(data) {
      // console.log(data)
      $(".new_answer_holder").append(data);
      $("#answer_body").val("");
    }).fail(function(data){
      console.log("ajax failed: " + data);
    })
  })
})
