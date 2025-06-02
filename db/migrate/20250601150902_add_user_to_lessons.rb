class AddUserToLessons < ActiveRecord::Migration[8.0]
  def change
    add_reference :lessons, :user, null: false, foreign_key: true
  end
end
