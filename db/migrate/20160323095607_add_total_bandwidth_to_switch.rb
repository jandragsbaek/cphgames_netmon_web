class AddTotalBandwidthToSwitch < ActiveRecord::Migration
  def change
    add_column :switches, :bandwidth_down, :decimal, default: 0
    add_column :switches, :bandwidth_up, :decimal, default: 0
  end
end
