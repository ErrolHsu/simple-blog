$(document).on('ready page:load',function() {
	$('.each-day:has(.hide-event-box)').on('click', function(evt) {
		evt.stopPropagation();
		var event_box = $(this).find('.hide-box').clone();
		var container = $(this).parent().next();
		$(this).siblings().css('background', '#f1f2f3');
		$(this).css('background', '#aac1bf');
		container.find('div').replaceWith(event_box);
		container.slideDown(150, function() {
		  event_box.css('display', 'block');
		});
	}); // end click
	$('body').click(function(evt) {
		if ($(evt.target).find('.hide-event-box').length == 0) {
			$('.hide-row-box').slideUp(200, function() {
				$('.each-day').css('background', '#f1f2f3');
			});
		};
	}); // end click
}); // end ready




