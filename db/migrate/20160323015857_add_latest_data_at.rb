class AddLatestDataAt < ActiveRecord::Migration
  def change
    add_column :switches, :latest_data_at, :timestamp, default: 10.years.ago
  end
end
