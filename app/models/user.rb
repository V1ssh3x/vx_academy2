class User < ApplicationRecord
  has_secure_password

  has_many :enrollments
  has_many :enrolled_courses, through: :enrollments, source: :course # курси, на які підписаний користувач
  has_many :courses, dependent: :destroy # курси, які створив користувач

  has_one_attached :avatar

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :nickname, presence: true
  validates :role, presence: true, inclusion: { in: %w[student teacher] }
end
