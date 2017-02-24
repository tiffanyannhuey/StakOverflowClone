
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
    redirect "/questions/#{@question.id}"
  else
    @errors = @question.errors.full_messages.join(" ")
    erb :'questions/new'
  end
end

# Show
get '/questions/:id' do

  puts current_question
  puts current_question.answers
  erb :'questions/show'
end

