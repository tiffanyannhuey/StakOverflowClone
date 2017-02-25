
# New
get '/questions/new' do
  redirect "/" if !current_user
  @question = Question.new()
  erb :'questions/new'
end

# Create
post '/questions' do
  # params[:question][:author_id] = 1
  user = current_user
  @question = Question.new(params[:question]) 
  @question.author_id = user.id 
    if @question.save
      redirect "/questions/#{@question.id}"
    else
      @errors = @question.errors.full_messages
      erb :'questions/new'
    end
end

# Show
get '/questions/:id' do
  erb :'questions/show'
end

