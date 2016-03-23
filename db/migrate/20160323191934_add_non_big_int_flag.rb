class AddNonBigIntFlag < ActiveRecord::Migration
  def change
    add_column :switches, :bigint, :boolean, default: true
  end
end
