class CreateOrders < ActiveRecord::Migration
	
  def change
    create_table :orders do |t|
    	t.integer :user_id
    	t.integer :invitation_id
    	t.float :price

      t.timestamps
    end
  end
end
