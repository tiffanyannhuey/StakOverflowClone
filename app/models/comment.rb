class Comment < ActiveRecord::Base
  belongs_to :author, {class_name: :User, foreign_key: :author_id}
  belongs_to :commentable, polymorphic: true
  has_many :votes, as: :votable

  def vote_total
    sum = 0
    votes.each{ |vote| sum += vote.value }
    sum
  end
end
