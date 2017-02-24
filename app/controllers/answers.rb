
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

