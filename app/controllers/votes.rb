post "/votable/:votable_type/:votable_id/votes/:value" do
  redirect "/questions/#{params[:question_id]}" if !current_user || !["-1","1"].include?(params[:value])

  new_vote = current_user.votes.new(votable_id:    params[:votable_id],
                                    votable_type:  params[:votable_type],
                                    value:         params[:value].to_i)
  if new_vote.valid?
    new_vote.save
    if request.xhr?
      new_vote.value == 1 ? "upvoted" : "downvoted"
    else
      redirect "/questions/#{params[:question_id]}"
    end
  else
    old_vote = Vote.find_by(user: current_user, votable_id: params[:votable_id], votable_type: params[:votable_type])
    old_vote.destroy
    new_vote.save
    p request
    if request.xhr?
      new_vote.value == 1 ? "upvoted" : "downvoted"
    else
      puts "tryna redirect"
      redirect "/questions/#{params[:question_id]}"
    end
  end
end
