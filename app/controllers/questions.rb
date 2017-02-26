
# New
get '/questions/new' do
  redirect "/" if !current_user
  @question = Question.new()
  if request.xhr?
    erb :'questions/new', layout: false
  else
    erb :'questions/new'
  end
end

# Create
post '/questions' do
  # params[:question][:author_id] = 1
  user = current_user
  @question = Question.new(params[:question]) 
  @question.author_id = user.id 
    if @question.save
      status 200
      if request.xhr?
        erb :'/questions/show', layout: false
      else  
        redirect "/questions/#{@question.id}"
      end
    else
      status 422
      @errors = @question.errors.full_messages
      if request.xhr?
        # @errors.map{|error| error.to_s+" "}
        @errors.to_s
      else  
        erb :'questions/new'
      end
    end
end

# Show
get '/questions/:id' do
  erb :'questions/show'
end

