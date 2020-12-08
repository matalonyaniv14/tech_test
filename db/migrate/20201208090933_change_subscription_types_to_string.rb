class ChangeSubscriptionTypesToString < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :subscription_type, :integer
    add_column :users, :subscription_type, :string
  end
end
