get '/questions/:id/comments/new' do
	current_question
	erb :'comments/new'
end

post '/questions/:id/comments/new' do
	comment = Comment.new(description: params[:comment])
	comme
end