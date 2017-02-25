class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  belongs_to :user

  scope :sort_by_votable_type, -> {all.sort{|a,b| b.votable_type <=> a.votable_type }}

  validates :user_id, :votable_id, :votable_type, :value, presence: true
end
