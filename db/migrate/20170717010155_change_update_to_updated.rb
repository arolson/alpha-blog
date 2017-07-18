class ChangeUpdateToUpdated < ActiveRecord::Migration[5.1]
  def change
    rename_column :articles, :update_at, :updated_at 
  end
end
