class AddedToGoogleCalendar < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :added_to_google_calendar, :boolean, :default => false
  end
end
