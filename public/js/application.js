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
				// console.log(arrow.closest("form"));
				// console.log(arrow.closest("form").siblings("form"));
				// console.log(arrow.closest("form").siblings("form").find(".upvoted, .downvoted"));
				arrow.closest("form").siblings("form").find(".upvoted, .downvoted").css("border-bottom-color", "#a1a1a1").css("border-top-color", "#a1a1a1");
				// console.log(arrow);
				// console.log(response);
				arrow.css("border-bottom-color", "").css("border-top-color", "").removeClass().addClass(response);
			})

		} else {
			//Tell them they need to be logged in
			console.log("Not logged in");
			$(this).closest("form").append("<div class='vote-not-logged-in'>You need to be logged in to vote</div>")
		}
	}

	// Dynamically bind to all possible classes the arrows can have
	$('body').on('click', '.arrow-up-btn',   voting);
	$('body').on('click', '.arrow-down-btn', voting);
	$('body').on('click', '.upvoted',   	 voting);
	$('body').on('click', '.downvoted',      voting);
});
