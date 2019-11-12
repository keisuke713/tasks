class Task < ApplicationRecord
  validates :title, presence: true
  validates :detail, presence: true
  validates :deadline, presence: true, deadline: true
  validates :label, presence: true
  enum status: [:waiting, :working, :completed]
  belongs_to :user
end
