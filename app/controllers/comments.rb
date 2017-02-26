


get '/questions/:id/comments/new' do
	current_question
	erb :'comments/new'
end

post '/questions/:question_id/comments' do
	redirect "/questions/#{params[:question_id]}" if !current_user
	@comment = Comment.new(description: params[:comment],
						  commentable: Question.find_by(id: params[:question_id]),
						  author_id: session[:user_id])
	if @comment.save
		if request.xhr?
			erb(:'comments/_comment', layout: false)
		else
			redirect "/questions/#{comment.commentable.id}"
		end
	else
		if request.xhr?
			status 442
		else
			@errors = comment.errors.full_messages
			erb :'questions/show'
		end
	end
end

post '/questions/:id/answers/:answer_id/comments' do
	redirect "/questions/#{params[:question_id]}" if !current_user
	@comment = Comment.new(description: params[:comment],
						  commentable: Answer.find_by(id: params[:answer_id]),
						  author_id: session[:user_id])
	if @comment.save
		if request.xhr?
			erb(:'comments/_comment', layout: false)
		else
			redirect "/questions/#{current_question.id}"
		end
	else
		if request.xhr?
			status 442
		else
			@errors = comment.errors.full_messages
			erb :'questions/show'
		end
	end
end