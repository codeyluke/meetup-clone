class Event < ApplicationRecord
    has_many :attendees
    has_many :users, :through => :attendees

    def self.search_event_title(search)
        event_title = search["event_title"]
        Event.where("event_title ILIKE ?", "%#{event_title}%")   
    end

    def self.search_event_description(search)
        description = search["description"]
        events = Event.where("description ILIKE ? ", "%#{description}%")        
    end

    def self.search_event_date(search)
        date = search["date"]
        events = Event.where(start_date: "#{date}")
    end
    
    def self.search_event_other_dates(search)
        events = Event.all
        attendees = Attendee.all
        date = search["date"]
        ten_days_before = (date.to_date - 10).to_s
        ten_days_after = (date.to_date + 10).to_s
        Event.where(start_date: "#{ten_days_before}".."#{ten_days_after}" )
    end
end
