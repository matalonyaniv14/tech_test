class CreateUserCourseModules < ActiveRecord::Migration[6.0]
  def change
    create_table :user_course_modules do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course_module, null: false, foreign_key: true
      t.boolean :completed

      t.timestamps
    end
  end
end
