class AddColumnToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :mobile, :string
    add_column :users, :user_type, :string, null: false, default: "user"
  end
end
