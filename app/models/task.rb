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
#  owner_id    :bigint           not null
#  code        :string
#
class Task < ApplicationRecord
  belongs_to :category
  belongs_to :owner, class_name: 'User'
  has_many :participant_users, class_name: 'Participant'
  has_many :participants, through: :participant_users, source: :user
  has_many :notes

  validates :participant_users, presence: true
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :description, presence: true
  validate :due_date_validity

  before_create :create_code
  after_create :send_email

  accepts_nested_attributes_for :participant_users, allow_destroy: true

  private

  def due_date_validity
    return if due_date.blank? || due_date > Date.today
    errors.add :due_date, I18n.t('tasks.errors.invalid_due_date')
  end

  def create_code
    self.code = "#{owner.id}#{Time.now.to_i.to_s(36)}#{SecureRandom.hex(8)}"
  end

  def send_email
    (participants + [owner]).each do |user|
      ParticipantMailer.with(user: user, task: self).new_task_email.deliver!
    end
  end
end
