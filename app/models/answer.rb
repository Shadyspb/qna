class Answer < ApplicationRecord
  include Voted
  include Commented

  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy

  validates :body, presence: true

  after_create :dispatch_new_answer, on: :create

  scope :sort_by_best, -> { order(best: :desc) }

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  def mark_best
    transaction do
      question.answers.update_all(best: false)
      reload.update!(best: true)
    end
  end

  def dispatch_new_answer
    NewAnswerDispatchJob.perform_later(self)
  end
end
