class Lesson < ApplicationRecord
  belongs_to :course
  belongs_to :user        # автор уроку (може бути той самий, що і у курсу)


  validates :title, presence: true
  validates :content, presence: true

  # Простий парсер посилань із тексту (опціонально)
  def links
    URI.extract(content, [ "http", "https" ])
  end
end
