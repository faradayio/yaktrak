class CreateTrackings < ActiveRecord::Migration
  def self.up
    create_table :trackings, :id => false do |t|
      t.integer :package_identifier
      t.timestamps
    end
  end

  def self.down
    drop_table :trackings
  end
end
