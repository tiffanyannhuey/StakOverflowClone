class Comment < ActiveRecord::Base
  belongs_to :author, {class_name: :User, foreign_key: :author_id}
  belongs_to :commentable, polymorphic: true
  has_many :votes, as: :votable

  validates :description, :author_id, :commentable_type, :commentable_id, presence: true

  scope :most_recent, -> {all.order(:created_at).limit(5)}
  scope :sort_by_commentable_type, -> {all.sort{|a,b| b.commentable_type <=> a.commentable_type }}

  def vote_total
    votes.reduce(0) {|sum, vote| sum + vote.value}
  end

  def self.most_votes
    Comment.all.sort{|c1, c2| c2.vote_total <=> c1.vote_total }
  end


end
