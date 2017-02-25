
# create a new answer to the question
post '/questions/:id/answers/new' do

  user = User.find_by(id: session[:user_id])
  question = Question.find(params[:id])
  answer = Answer.new( description: params[:description], question_id: question.id  )
  if currently_logged_in? && answer
    answer.author_id = user.id
    answer.save
    redirect "/questions/#{question.id}"
  else
    @answer_error = "There was an issue submitting your answer. Please log in and try again."
    erb :"/questions/show"
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

