class Task < ApplicationRecord
  validates :title, presence: true
  validates :detail, presence: true
  validates :deadline, presence: true, deadline: true
  validates :label, presence: true
  enum status: [:untouched, :in_progress, :done]
  belongs_to :user, optional: true

  def created_by_current_user?(current_user)
    user_id == current_user&.id
  end

  def self.fetch_instance_close_deadline(user)
    user.tasks.select do |task|
      task.deadline_is_today?
    end
  end

  def self.fetch_instance_passed_deadline(user)
    user.tasks.select do |task|
      task.deadline < Date.today && task.status != 'done'
    end
  end

  def deadline_is_today?
    self.deadline == Date.today
  end
end
