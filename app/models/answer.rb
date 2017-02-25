class Answer < ActiveRecord::Base
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  belongs_to :author, class_name: :User, foreign_key: :author_id
  belongs_to :question

  scope :comments, -> {all.order(:created_at)}
 
  
  def vote_total
    votes.reduce(0) {|sum, vote| sum + vote.value}
  end

  def self.most_votes
    Answer.all.sort{|a1, a2| a2.vote_total <=> a1.vote_total }
  end

end
