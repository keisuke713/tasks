class Task < ApplicationRecord
  validates :title, presence: true
  validates :detail, presence: true
  validates :deadline, presence: true, deadline: true
  validates :label, presence: true
  enum status: [:waiting, :working, :completed]
  belongs_to :user, optional: true

  def created_by_current_user?(current_user)
    user_id == current_user.id
  end
end
