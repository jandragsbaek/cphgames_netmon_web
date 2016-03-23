class AddSwitchesTable < ActiveRecord::Migration
  def change
    create_table :switches do |t|
      
      t.string :source
      t.string :destination
      t.integer :uptime
      t.string :ip
      t.string :description
      t.boolean :alive

      t.timestamps
    end
  end
end
