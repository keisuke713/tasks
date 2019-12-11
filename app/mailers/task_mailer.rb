class TaskMailer < ApplicationMailer
  default from: 'taskleaf@example.com'

  def self.send_email
    User.all.each do |user|
      self.creation_email(user, Task.fetch_instance_close_deadline(user), Task.fetch_instance_passed_deadline(user)).deliver_now
    end
  end

  def creation_email(user, tasks_close_deadline, tasks_passed_deadline)
    @tasks_close_deadline = tasks_close_deadline
    @tasks_passed_deadline = tasks_passed_deadline
    mail(to: user.email, subject: 'test_mail') unless @tasks_close_deadline.empty? && @tasks_passed_deadline.empty?
  end
end
