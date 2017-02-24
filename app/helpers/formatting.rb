helpers do

  def current_question
    @current_question ||= Question.find_by(id: params[:id])
  end

  def best_answer
    @best_answer ||= Answer.find_by(id: current_question.best_answer)
  end

  # def current_answer(id)
  #   @current_answer ||= Answer.find_by(id: id)
  # end

end
