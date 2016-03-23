class AddDatapointsTable < ActiveRecord::Migration
  def change
    create_table :datapoints do |t|
      t.belongs_to :switch, index: true
      t.integer :port
      t.string :direction
      t.decimal :speed

      t.timestamps
    end
  end
end
