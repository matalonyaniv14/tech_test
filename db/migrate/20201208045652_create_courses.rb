class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.integer :position
      t.string :name
      t.string :description
      t.references :course_module, null: false, foreign_key: true

      t.timestamps
    end
  end
end
