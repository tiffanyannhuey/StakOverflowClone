helpers do

  def current_question
    @current_question ||= Question.find_by(id: params[:id])
  end

  def best_answer
    @best_answer ||= Answer.find_by(id: current_question.best_answer)
  end

  def user_upvote(votable)
  	@user_vote = Vote.find_by(votable_id: votable.id, votable_type: votable.class.to_s, user_id: current_user.id, value: 1)
  end

  def user_downvote(votable)
  	@user_vote = Vote.find_by(votable_id: votable.id, votable_type: votable.class.to_s, user_id: current_user.id, value: -1)
  end

end
