$(document).on('ready page:load', function() {
	$("#category-form").hide();
	$('#old-category').hide();
	$('.category-controller a').on('click', function(evt) {
		evt.preventDefault();
		$("#category-form").toggle();
		$('#category-select').toggle();
		$('#new-category').toggle();
		$('#old-category').toggle();
	});
});