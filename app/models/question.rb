class Question < ActiveRecord::Base
  belongs_to :author, {class_name: :user, foreign_key: :author_id}
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
end
