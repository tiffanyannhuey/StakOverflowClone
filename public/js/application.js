$(document).ready(function() {
	$('a#login').on('click', function(event){
		event.preventDefault();
		var loginUrl = $(this).attr('href');
		$.ajax({
			method: "GET",
			url: loginUrl
		})
			.done(function(response){
				$('nav').after(response)
			});

	$('body').on('submit', 'form#login', function(event){
		event.preventDefault()
		var loginData = $(this).serialize()
		var loginUrl = $(this).attr('action')
		$.ajax({
			method: "POST",
			url: loginUrl,
			data: loginData
		})
			.done(function(response){
				console.log("SUCCESS")
				$('body').html(response)
			})
			.fail(function(response){
				var p = $('<p></p>')
				p.html(response.responseText)
				$('body').find('form').closest('div').find('h1').append(p)
			})
		})
	})

	$('body').on('click', 'button.ask-btn', function(event){
		event.preventDefault()
		console.log("PREVENTED")
		console.log($(this))
		var askUrl = $(this).closest('a').attr('href')
		$.ajax({
			method: "GET",
			url: askUrl
		})
			.done(function(response){
				console.log(response)
				$('nav').after(response)
			})
	})

	$('body').on('submit', 'form.question-form', function(event){
		event.preventDefault()
		console.log("PREVENTED")
		
		var questionData = $(this).serialize()
		var questionUrl = $(this).attr('action')
		console.log(questionUrl, questionData)
		$.ajax({
			method: "POST",
			url: questionUrl,
			data: questionData
		})
			.done(function(response){
				console.log("SUCCESS", response)
			})
			.fail(function(response){
				// alert(response.responseText)
			
			})
	
	})



});
