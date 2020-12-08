class AddSubscriptionTypesToCourseModule < ActiveRecord::Migration[6.0]
  def change
    add_column :course_modules, :subscription_type, :string
  end
end
