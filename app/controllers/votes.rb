post "/votable/:votable_type/:votable_id/votes/:value" do
  redirect "/questions/#{params[:question_id]}" if !current_user
  puts params
  new_vote = current_user.votes.new(votable_id:    params[:votable_id],
                                    votable_type:  params[:votable_type],
                                    value:         params[:value].to_i)
  puts new_vote
  if new_vote.valid?
    new_vote.save
    redirect "/questions/#{params[:question_id]}"
  else
    old_vote = Vote.find_by(user: current_user, votable_id: params[:votable_id], votable_type: params[:votable_type])
    old_vote.destroy
    new_vote.save
    redirect "/questions/#{params[:question_id]}"
  end
end
