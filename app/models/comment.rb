class Comment < ActiveRecord::Base
  belongs_to :author, {class_name: :user, foreign_key: :author_id}
  belongs_to :commentable, polymorphic: true
  has_many :votes, as: :votable
end