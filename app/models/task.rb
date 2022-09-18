# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  due_date    :date
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Task < ApplicationRecord
  belongs_to :category
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validate :due_date_validity

  def due_date_validity
    return if due_date.blank? || due_date > Date.today
    errors.add :due_date, I18n.t('tasks.errors.invalid_due_date')
  end
end
