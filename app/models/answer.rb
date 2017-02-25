class Answer < ActiveRecord::Base
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  belongs_to :author, class_name: :User, foreign_key: :author_id
  belongs_to :question

  validates :description, :author_id, :question_id, presence: true

  scope :comments, -> {all.order(:created_at)}
  scope :most_recent, -> {all.order(:created_at).limit(5)}
  
  def vote_total
    votes.reduce(0) {|sum, vote| sum + vote.value}
  end

  def self.most_votes
    Answer.all.sort{|a1, a2| a2.vote_total <=> a1.vote_total }
  end

  def self.most_comments
    Answer.all.sort{|a1, a2| a2.comments.count <=> a1.comments.count }
  end
end
