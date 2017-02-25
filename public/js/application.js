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
});
