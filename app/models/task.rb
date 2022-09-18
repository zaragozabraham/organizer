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
  belongs_to :owner, class_name: 'User'
  has_many :participant_users, class_name: 'Participant'
  has_many :participants, through: :participant_users, source: :user

  validates :participant_users, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validate :due_date_validity

  accepts_nested_attributes_for :participant_users, allow_destroy: true

  def due_date_validity
    return if due_date.blank? || due_date > Date.today
    errors.add :due_date, I18n.t('tasks.errors.invalid_due_date')
  end
end
