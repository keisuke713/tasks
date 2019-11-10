class DeadlineValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value < Date.today
      record.errors[:attribute] << "#{value}は過去の日付です"
    end
  end
end
