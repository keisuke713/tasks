class Task < ApplicationRecord
  enum status: [:waiting, :working, :completed]
end
