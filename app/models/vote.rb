class Vote < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  belongs_to :user

  validates :votable_id, :votable_type, :value, :user_id, {null:false}
  validates :user_id, uniqueness: {scope: :votable_type, scope: :votable_id}
end
