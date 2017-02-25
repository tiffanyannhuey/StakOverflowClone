
# New
get '/questions/new' do
  @question = Question.new()
  erb :'questions/new'
end

# Create
post '/questions' do
  # params[:question][:author_id] = 1
   user = current_user
  @question = Question.new(params[:question])
  if currently_logged_in? 
    @question.author_id = user.id #if logged in, add author_id to @question
    if @question.save 
      # current_question
      redirect "/questions/#{@question.id}"
    else
      @errors = @question.errors.full_messages
      erb :'questions/new'
    end
  else
    @errors = ["You must be logged in to post a question."]
    erb :'questions/new'
  end
end

# Show
get '/questions/:id' do
  erb :'questions/show'
end

