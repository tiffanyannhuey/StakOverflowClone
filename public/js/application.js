$(document).ready(function() {
	$('a#login').on('click', function(event){
		event.preventDefault();
		var loginUrl = $(this).attr('href');
		
		$.ajax({
			method: "GET",
			url: loginUrl
		})
			.done(function(response){
				console.log(response)
				$('ul.nav-ulist').hide()
				// $('ul.nav-ulist').hide()
				$('nav').html(response)
			});
	})


	var voting = function(event){
		event.preventDefault();
		// Check if there is a user logged in
		if ($('#profile').length > 0){
			var arrow = $(this);
			var route = arrow.closest('form').attr('action');
			$.ajax({
				url: route,
				method: "post"
			})
			.done(function(response){
				response = JSON.parse(response);

				//Update the new vote total
				var voteDiv = arrow.closest("form").siblings(".vote-total");
				var voteTotal = voteDiv.text();
				voteDiv.text(response["vote_total"])

				// Reset the css and inline styles
				arrow.closest("form").siblings("form").find(".upvoted, .downvoted").css("border-bottom-color", "#a1a1a1").css("border-top-color", "#a1a1a1");
				arrow.css("border-bottom-color", "").css("border-top-color", "").removeClass().addClass(response["class_name"]);
			})

		} else {
			//Tell them they need to be logged in
			errorMessage(this);
		}
	}

	var errorMessage = function(object){
		$(object).append("<div class='act-not-logged-in'>You need to be logged in to do that</div>");
		var message = $(object).find('.act-not-logged-in');
		message.css("top", ( $(object).offset().top - $(document).scrollTop() ) )
		message.fadeOut(3000, function(){message.remove()});
	};

	// Dynamically bind to all possible classes the arrows can have
	$('body').on('click', '.arrow-up-btn',   voting);
	$('body').on('click', '.arrow-down-btn', voting);
	$('body').on('click', '.upvoted',   	 voting);
	$('body').on('click', '.downvoted',      voting);
	
});
