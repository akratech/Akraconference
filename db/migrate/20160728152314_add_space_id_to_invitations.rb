class AddSpaceIdToInvitations < ActiveRecord::Migration
  def change
  	add_column :invitations, :space_id, :integer
  end
end
