class TaskMailer < ApplicationMailer
  default from: 'taskleaf@example.com'

  def self.send_email
    User.all.each do |user|
      self.creation_email(user, Task.fetch_instance_close_deadline(user)).deliver_now
    end
  end

  def creation_email(user, tasks)
    @tasks = tasks
    mail(to: user.email, subject: 'test_mail') unless @tasks.empty?
  end
end
