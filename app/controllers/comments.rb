

post '/questions/:id/answers/:answer_id/comments' do
	
	comment = Comment.new(description: params[:comment],
												commentable: Answer.find_by(id: params[:answer_id]),
												author_id: session[:id]
												)
	puts comment.inspect
	if comment.save
		puts comment.inspect
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