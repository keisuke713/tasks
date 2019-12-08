class TaskMailer < ApplicationMailer
  default from: 'taskleaf@example.com'

  def self.send_email
    User.all.each do |user|
      task_close_deadline = 
      user.tasks.select do |task|
        task.deadline == Date.today
        task.deadline_is_today?
      end
      self.creation_email(user, task_close_deadline).deliver_now
    end
  end

  def creation_email(user, tasks)
    @user = user
    @tasks = tasks
    mail(to: user.email, subject: 'test_mail') unless @tasks.empty?
  end
end
