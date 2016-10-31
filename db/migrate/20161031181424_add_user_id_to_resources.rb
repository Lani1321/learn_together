class AddUserIdToResources < ActiveRecord::Migration[5.0]
  def change
    add_column :resources, :user_id, :integer
  end
end
