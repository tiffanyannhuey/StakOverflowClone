class Question < ActiveRecord::Base
  belongs_to :author, {class_name: :User, foreign_key: :author_id}
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  has_many :answers
  scope :most_recent, -> {all.order(:created_at).limit(5)}

  validates :title, :description, :author_id, presence: true

  def vote_total
    sum = 0
    votes.each{ |vote| sum += vote.value }
    sum
  end

  def sneak_peak
    description.split(" ")[0..15].join(" ") + "..."
  end
end
