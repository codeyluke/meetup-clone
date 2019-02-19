class AddedToGoogleCalendarAttendee < ActiveRecord::Migration[5.2]
  def change
    add_column :attendees, :added_to_google_calendar, :boolean, :default => false
  end
end
