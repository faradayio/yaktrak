class StoreTrackingNuimberAsString < ActiveRecord::Migration
  def self.up
    change_column :trackings, :package_identifier, :string
  end

  def self.down
    change_column :trackings, :package_identifier, :integer
  end
end
