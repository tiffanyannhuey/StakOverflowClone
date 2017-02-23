class Answer < ActiveRecord::Base
  has_many :comments, as: :commentable
  has_many :votes, as: :votable

  scope :comments, -> {all.order(:created_at)}
end
