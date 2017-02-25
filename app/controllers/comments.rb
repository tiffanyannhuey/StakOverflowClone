
post '/questions/:id/answers/:answer_id/comments' do
	comment = Comment.new(description: params[:comment],
												commentable: Answer.find_by(id: params[:answer_id]),
												author_id: session[:user_id]
												)
	if comment.save
		redirect "/questions/#{current_question.id}"
	else
		@errors = comment.errors.full_messages
		erb :'questions/show'
	end
end

get '/questions/:id/comments/new' do
	current_question
	erb :'comments/new'
end

post '/questions/:question_id/comments' do
	comment = Comment.new(description: params[:comment],
												commentable: Question.find_by(id: params[:question_id]),
												author_id: session[:user_id]
												)
	if comment.save
		redirect "/questions/#{comment.commentable.id}"
	else
		@errors = comment.errors.full_messages
		erb :'questions/show'
	end
end
