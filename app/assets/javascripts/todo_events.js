$(document).on('ready page:load',function() {
	$('#todo-form').hide();
  $('#todo-form-controller').click(function(evt) {
  	evt.preventDefault();
    $('.glyphicon-plus').toggleClass('glyphicon-minus');
    $('#todo-form').slideToggle(300, 'linear', function() {
      $('#event-form').focus();
    }); // end slide
  }); // end click
}); // end ready
