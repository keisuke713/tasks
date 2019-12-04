class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tasks
  def self.shout
    self.all.each do |user|
      task_close_deadline =
      user.tasks.select do |task|
        task.deadline == Date.today
      end
      p task_close_deadline
    end
  end
end
