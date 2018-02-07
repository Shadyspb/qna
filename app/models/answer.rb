class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  validates :body, presence: true

  scope :sort_by_best, -> {order(best: :desc)}

  def mark_best
    transaction do
      question.answers.update_all(best: false)
      reload.update!(best: true)
    end
  end
end
