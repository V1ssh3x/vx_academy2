class Course < ApplicationRecord
  belongs_to :user        # автор курсу

  has_many :enrollments
  has_many :users, through: :enrollments
  has_many :lessons, dependent: :destroy

  validates :title, presence: true
  has_many :lessons, dependent: :destroy
end
