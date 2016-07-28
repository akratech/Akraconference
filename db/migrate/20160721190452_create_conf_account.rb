class CreateConfAccount < ActiveRecord::Migration
  def change
    create_table :conf_accounts do |t|
    	t.integer :user_id
    	t.integer :product_id
      t.float :credits
      t.integer :total_sessions
      t.float :storage
      t.string :total_usage
      t.integer :total_persons
      t.integer :duration
    end
  end
end
