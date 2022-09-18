class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # avoid same name in relations, owned task vs task
  has_many :owned_tasks
  has_many :participations, class_name: 'Participant'
  has_many :tasks, through: :participations
end
