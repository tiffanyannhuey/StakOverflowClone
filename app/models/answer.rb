class Answer < ActiveRecord::Base
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  belongs_to :author, class_name: :User, foreign_key: :author_id

  scope :comments, -> {all.order(:created_at)}

  def vote_total
    sum = 0
    votes.each{ |vote| sum += vote.value }
    sum
  end
end
