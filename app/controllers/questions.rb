
# New
get '/questions/new' do
  @question = Question.new()
  erb :'questions/new'
end

# Create
post '/questions' do
  # params[:question][:author_id] = 1
  @question = Question.new(params[:question])
  if @question.save
    # current_question
    redirect "/questions/#{@question.id}"
  else
    @errors = @question.errors.full_messages.join(" ")
    erb :'questions/new'
  end
end

# Show
get '/questions/:id' do
  erb :'questions/show'
end

