class AddColumnOnStartTime < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :time_start, :datetime
  end
end
