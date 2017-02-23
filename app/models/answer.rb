class Answer < ActiveRecord::Base
  has_many :comments, as: :commentable
  has_many :votes, as: :votable

  scope :comments, -> {all.order(:created_at)}

  def vote_total
    self.votes.reduce{ |sum, vote| vote.value }
  end
end
