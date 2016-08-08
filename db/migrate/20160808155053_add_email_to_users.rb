class AddEmailToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :adaptive_payment_email, :string
  end
end
