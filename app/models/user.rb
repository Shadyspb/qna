class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions, dependent: :destroy
  has_many :answers
  has_many :votes

  def author_of?(object)
    id == object.user_id
  end
end
