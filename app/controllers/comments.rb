get '/questions/:id/comments/new' do
	current_question
	erb :'comments/new'
end

post '/questions/:id/comments' do
	
	comment = Comment.create(description: params[:comment],
												commentable: current_question,
												author_id: session[:id]
												)
	
	if comment.valid?
		puts comment.inspect
		redirect "/questions/#{current_question.id}"
	else
		@errors = comment.errors.full_messages
		erb :'questions/show'
	end
end