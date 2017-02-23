get '/questions/new' do
  @question = Question.new()
  erb :'questions/new'
end

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

get '/questions/:id' do
  erb :'questions/show'
end
