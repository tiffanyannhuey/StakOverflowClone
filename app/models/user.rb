require 'bcrypt'

class User < ActiveRecord::Base
  has_many :comments, foreign_key: :author_id
  has_many :questions, foreign_key: :author_id
  has_many :votes
  has_many :answers, foreign_key: :author_id

  validates :password, presence: true
  validates :username, :email, presence: true, uniqueness: true

  def password
    @password ||= BCrypt::Password.new(hashed_password)
  end

  def password=(given_password)
    self.hashed_password = BCrypt::Password.create(given_password)
  end

  def authenticate(given_password)
    self.password == given_password
  end
end
