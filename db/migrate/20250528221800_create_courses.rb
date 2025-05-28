class CreateCourses < ActiveRecord::Migration[8.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.string :image
      t.string :category

      t.timestamps
    end
  end
end
