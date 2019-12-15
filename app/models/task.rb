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
  
  def deadline_is_today?
    self.deadline == Date.today
  end

  class << self
    def fetch_instance_close_deadline(user)
      user.tasks.select do |task|
        task.deadline_is_today?
      end
    end

    def fetch_instance_passed_deadline(user)
      user.tasks.select do |task|
        task.deadline < Date.today && task.status != 'done'
      end
    end

    def csv_attributes
      %W(title detail deadline status label user_id created_at updated_at)
    end

    def generate_csv
      CSV.generate(headers: true) do |csv|
        csv << csv_attributes
        all.each do |task|
          csv << csv_attributes.map { |attr| task.send(attr) }
        end
      end
    end
    def import(file)
      CSV.foreach(file.path, headers: true) do |row|
        task = new
        task.attributes = row.to_hash.slice(*csv_attributes)
        task.save!
      end
    end
  end
end
