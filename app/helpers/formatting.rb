helpers do

  def current_question
    @current_question ||= Question.find_by(id: params[:id])
  end

  def best_answer
    @best_answer ||= Answer.find_by(id: current_question.best_answer)
  end

  def vote_total(votable)
    votable.votes.reduce{ |sum, vote| vote.value }
  end

end
