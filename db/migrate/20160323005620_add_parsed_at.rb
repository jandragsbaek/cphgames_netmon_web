class AddParsedAt < ActiveRecord::Migration
  def change
    add_column :switches, :parsed_at, :timestamp
  end
end
