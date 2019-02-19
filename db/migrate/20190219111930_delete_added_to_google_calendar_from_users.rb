class DeleteAddedToGoogleCalendarFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :added_to_google_calendar
  end
end
