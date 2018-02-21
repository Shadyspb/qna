class Question < ApplicationRecord
  include Voted
  include Commented

  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, foreign_key: "user_id"

  belongs_to :user

  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  after_create :subscribe_owner

  scope :last_day, -> { where(created_at: 24.hours.ago..Time.now) }

  def subscribe(user)
    subscriptions.create!(subscriber: user)
  end

   def unsubscribe(user)
    subscriptions.where(subscriber: user).destroy_all
  end

  def subscribed?(user)
    subscriptions.exists?(subscriber: user)
  end

  private

  def subscribe_owner
    subscriptions.create!(subscriber: user)
  end
end
