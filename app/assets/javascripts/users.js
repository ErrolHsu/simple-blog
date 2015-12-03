$(document).on('ready page:load',function() {
	$('#calendar .each-day').on('click', function(evt) {
		evt.stopPropagation() 
		var self = $(this)
		var event_box = $(this).find('.hide-box').clone();
		var container = $(this).parent().next();
		if ( $(this).find('.hide-event-box').length > 0 ) {
			self.siblings().css('background', '#f1f2f3');
		  self.css('background', '#79afc1');
		  container.slideDown(150, function() {
		    container.find('div').replaceWith(event_box);
		    event_box.css('display', 'block');
		  });
	  } else {
	  	$('.hide-row-box').slideUp(150, function() {
	  		$('.each-day').css('background', '#f1f2f3');
	  	});
	  };
	});
}); // end ready




