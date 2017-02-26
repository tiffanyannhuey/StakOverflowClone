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
		var askUrl = $(this).closest('a').attr('href')
		$.ajax({
			method: "GET",
			url: askUrl
		})
			.done(function(response){
				$('nav').after(response)
			})
	})

	$('body').on('submit', 'form.question-form', function(event){
		event.preventDefault()
		var form = $(this)
		console.log(form)
		var questionData = $(this).serialize()
		var questionUrl = $(this).attr('action')
		$.ajax({
			method: "POST",
			url: questionUrl,
			data: questionData
		})
			.done(function(response){
				form.trigger("reset")
				form.hide()
				console.log(response)
				// $('div.content').append(response)
			})
			.fail(function(response){
				response = JSON.parse(response.responseText)
				response.errors.forEach(function(text){
					var p = $('<p></p>')
					p.html(text)
					$('body').find('form').closest('div').find('h1').append(p)
				}) 
			})
	})
	//=============================================================================
	//Ajax voting

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
			errorMessage(this, "You must be logged in to vote");
		}
	}

	//================================================================================
	// Reusable error alert popup

	var errorMessage = function(object, error){
		$(object).append("<div class='error-alert'>"+error+"</div>");
		var message = $(object).find('.error-alert');
		message.css("top", ( $(object).offset().top - $(document).scrollTop()) )
		message.fadeOut(3000, function(){message.remove()});
	};


  $("#answer-form").on("submit", function(event){
    event.preventDefault();
    var answer = $(this).serialize()
    var route = $(this).attr('action');

    if($(this).find(".new-answer-textarea").val() != ""){
	    // var answ
	    $.ajax({
	      url: route, 
	      method: "POST",
	      data: answer
	    })

	    .done(function(response){
	      console.log(response)
	      // console.log(response);
	      $(".answers").append(response);
	      $("textarea[name=description]").val('');
	    })
	}else{
		errorMessage(this, "Answer must not be blank")
	}

  })


	// Dynamically bind to all possible classes the arrows can have
	$('body').on('click', '.arrow-up-btn',   voting);
	$('body').on('click', '.arrow-down-btn', voting);
	$('body').on('click', '.upvoted',   	 voting);
	$('body').on('click', '.downvoted',      voting);

	//=================================================================================
	//Ajax for leaving a comment
	$(".comment-form").hide();
	$(".comments-header").before("<button class='comment-form-link'>Leave a comment</button>");

	$('body').on('click', '.comment-form-link', function(event){
		event.preventDefault();
		if ($("#profile").length === 1){
			$(this).hide();
			$(this).siblings("form.comment-form").slideDown();
		} else {
			errorMessage(this, "You must be logged in to comment");
		}
	})

	$('body').on('click', '.comment-submit-input', function(event){
		event.preventDefault();
		var form = $(this).closest('form');
		var route = form.attr('action');
		var formData = form.serialize();

		$.ajax({
			url: route,
			method: "post",
			data: formData
		})
		.done(function(response){
			var newComment = $(response);
			form.siblings(".comments").append(newComment);
			form.find(".comment-text-input").val("");
		})
		.fail(function(response){
			console.log("failed");
			errorMessage(form, "Comment must not be blank")
		})

	})



});
