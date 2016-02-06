$(document).on('ready page:load',function() {
	$('.each-day:has(.hide-event-box)').on('click', function(evt) {
		evt.stopPropagation();
		var event_box = $(this).find('.hide-events').clone();
		var container = $(this).parent().next();
		$(this).siblings().css('background', '#f1f2f3');
		$(this).css('background', '#dce1e1');
		container.find('div').replaceWith(event_box);
		container.slideDown(150, function() {
		  event_box.css('display', 'block');
		});
	}); // end click
	$('body').click(function(evt) {
		var box = $('.hide-row-box')
		if (!box.is(evt.target) && box.has(evt.target).length === 0) {
			box.slideUp(200, function() {
				$('.each-day').css('background', 'none');
			});
		};
	}); // end click
}); // end ready




