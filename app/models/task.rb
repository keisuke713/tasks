class Task < ApplicationRecord
  validates :title, presence: true
  validates :detail, presence: true
  validates :deadline, presence: true
  enum status: [:waiting, :working, :completed]
end
