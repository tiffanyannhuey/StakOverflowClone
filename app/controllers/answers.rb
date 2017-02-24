# new answer
get '/questions/:id/answers/new' do
  if currently_logged_in?
  question = current_question
  erb :"/answers/new"
  else
    @login_error = "You need to be logged in to answer a question"
    erb :"/questions/#{question.id}" #this is broken
  end
end

# create a new answer to the question
post '/questions/:id/answers/new' do
 p current_user.to_s
 p current_question.to_s
  # answer = Answer.new( description: params[:description], author_id: current_user.id , question_id: current_question.id )
  # if answer
  #   answer.save
  #   erb :"/questions/#{current_question.id}"
  # else
  #   @answer_error = "There was an issue submitting your answer. Try again."
  #   erb :"/questions/#{current_question.id}/answers/new"
  # end
end

