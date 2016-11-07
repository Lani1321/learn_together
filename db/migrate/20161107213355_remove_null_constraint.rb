class RemoveNullConstraint < ActiveRecord::Migration[5.0]
  def up
    remove_column :users, :email
    add_column :users, :email, :string, :default => ''
  end

  def down 
    remove_column :users, :email
    add_column :users, :email, :string, :default => '', :null => false
  end
end
