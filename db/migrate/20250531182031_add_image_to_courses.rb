class AddImageToCourses < ActiveRecord::Migration[8.0]
  def change
    add_column :courses, :image, :string
  end
end
