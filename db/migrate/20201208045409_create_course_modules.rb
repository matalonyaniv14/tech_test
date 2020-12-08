class CreateCourseModules < ActiveRecord::Migration[6.0]
  def change
    create_table :course_modules do |t|
      t.string :name
      t.string :description
      t.integer :course_length

      t.timestamps
    end
  end
end
