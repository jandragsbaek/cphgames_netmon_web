class AddSwitchGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name

      t.timestamps
    end

    add_column :switches, :group_id, :integer, default: 1

    Group.create name: 'No group'
  end
end
