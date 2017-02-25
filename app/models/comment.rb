class Comment < ActiveRecord::Base
  belongs_to :author, {class_name: :User, foreign_key: :author_id}
  belongs_to :commentable, polymorphic: true
  has_many :votes, as: :votable

  def vote_total
    votes.reduce(0) {|sum, vote| sum + vote.value}
  end
end
