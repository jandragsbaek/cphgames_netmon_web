class AddReadingsTable < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.integer :bytes, limit: 8
      t.belongs_to :switch, index: true
      t.integer :port, default: 0
      t.string :direction, default: 'in'

      t.timestamps
    end
  end
end
