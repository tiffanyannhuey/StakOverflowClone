
# create a new answer to the question
post '/questions/:id/answers' do
  puts params.inspect
  user = User.find_by(id: session[:user_id])
  question = Question.find(params[:id])
  puts "This is the answer field"
  puts params[:description]
  @answer = Answer.new(description: params[:description], question_id: question.id  )
  puts "OUTSIDE " * 10
  if @answer && currently_logged_in? && request.xhr? 
    puts "INSIDE WITH JQUERY " * 10
    @answer.author_id = user.id
    @answer.save
    puts @answer.inspect
    erb :'answers/answers-partial', layout: false
  else
    puts "NOT JQUERY " * 10
    if answer && currently_logged_in? 
      puts "VALID ANSWER " * 10
      answer.author_id = user.id
      answer.save
      redirect "/questions/#{question.id}"
    else
      @answer_error = "There was an issue submitting your answer. Please log in and try again."
      erb :"/questions/show"
    end
  end
end

post "/questions/:question_id/answers/:answer_id/mark-best" do
  question = Question.find_by(id: params[:question_id])
  answer   = Answer.find_by(id: params[:answer_id])
  if question && answer
    question.update(best_answer: answer.id)
    redirect "/questions/#{params[:question_id]}"
  else
    redirect "/"
  end
end

