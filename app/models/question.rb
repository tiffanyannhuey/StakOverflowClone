class Question < ActiveRecord::Base
  belongs_to :author, {class_name: :User, foreign_key: :author_id}
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  has_many :answers
  scope :most_recent, -> {all.order(:created_at).limit(5)}
  # scope :most_votes, -> {all.each}

  validates :title, :description, :author_id, presence: true
 

  def vote_total
    votes.reduce(0) {|sum, vote| sum + vote.value}
  end

  def self.most_votes
    Question.all.sort{|q1, q2| q2.vote_total <=> q1.vote_total }
  end

  def sneak_peak
    description.split(" ")[0..15].join(" ") + "..."
  end
end
