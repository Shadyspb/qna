module Voted
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :appraised, dependent: :destroy
  end

  def vote_up(user)
    votes.create!(vote: 1, user: user)
  end

  def vote_down(user)
    votes.create!(vote: -1, user: user)
  end

  def vote_score
    votes.sum(:vote)
  end

  def voted?(user)
    votes.exists?(user: user)
  end

  def vote_reset(user)
    votes.where(user: user).delete_all
  end
end
