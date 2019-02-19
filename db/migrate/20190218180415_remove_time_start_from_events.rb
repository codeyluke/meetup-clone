class RemoveTimeStartFromEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :time_start
  end
end
