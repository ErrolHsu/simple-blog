$(document).on('ready page:load',function() {
	$('#todo-form').hide();
  $('#todo-form-controller').click(function(evt) {
    $('#todo-form').slideToggle(300);
    $('.glyphicon-plus').toggleClass('glyphicon-minus');
  })
});
