class AddUploadAndDownloadToSwitch < ActiveRecord::Migration
  def change
    add_column :switches, :in_speed, :decimal, default: 0
    add_column :switches, :out_speed, :decimal, default: 0
  end
end
