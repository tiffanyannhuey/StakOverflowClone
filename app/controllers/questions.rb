
# New
get '/questions/new' do
  redirect "/" if !current_user
  @question = Question.new()
  if request.xhr?
    erb :'questions/new', layout: false
  else
    # @question = Question.new()
    erb :'questions/new'
  end
end

# Create
post '/questions' do
  user = current_user
  puts "QUESTION" * 10
  puts params[:question]
  @question = Question.new(params[:question]) 
  @question.author_id = user.id 
  puts @question.inspect
    if @question.save
      puts @question.inspect
      status 200
      if request.xhr?
        @question.to_json
        # erb :'/questions/show', layout: false
      else  
        redirect "/questions/#{@question.id}"
      end
    else
      status 422
      @errors = @question.errors.full_messages
      if request.xhr?
        @errors.map{|error| error.to_s+" "}
        {errors: @errors}.to_json
      else  
        erb :'questions/new'
      end
    end
end

# Show
get '/questions/:id' do
  erb :'questions/show'
end

