class EventPermalink < ActiveRecord::Migration
  def self.up
    add_column :events, :permalink, :string
    Event.record_timestamps =false
    Event.all.each do |event|
      event.permalink = event.__send__(:create_permalink_for, [:name])
      event.save!
    end
  end

  def self.down
    remove_column :events, :permalink
  end
end
