$(document).on('ready page:load', function() {
	$('iframe').each(function() {
		var video = $(this).clone();
		var video_container = $("<div class='video'></div>").append(video);
		$(this).replaceWith(video_container);
	});
});