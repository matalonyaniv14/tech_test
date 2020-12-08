class AddTypeToCourse < ActiveRecord::Migration[6.0]
  def change
    add_column :courses, :type, :string
  end
end
