class RenameColumnEvents < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :start_date, :date
  end
end
