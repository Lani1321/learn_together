class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.integer :vote_value
      t.integer :resource_id
    end
  end
end
