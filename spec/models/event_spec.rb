require 'rails_helper'

RSpec.describe Event, type: :model do
    context "validation tests" do 
        ########################################### HAPPY ###########################################
        it "ensure presence of title" do 
            event = Event.new(location: "location", description: "describe", start_time: Time.now, end_time: Time.now).save
            expect(event).to eq(false)
        end

        it "ensure presence of start_time" do 
            event = Event.new(event_title: "title", location: "location", description: "describe", end_time: Time.now).save
            expect(event).to eq(false)    
        end

        it "ensure presence of end_time" do 
            event = Event.new(event_title: "title", location: "location", description: "describe", start_time: Time.now).save
            expect(event).to eq(false)
        end

        it "ensure presence of location" do 
            event = Event.new(event_title: "title", description: "describe", start_time: Time.now, end_time: Time.now).save
            expect(event).to eq(false)
        end
        
        it "ensure presence of description" do 
            event = Event.new(event_title: "title", location: "location", start_time: Time.now, end_time: Time.now).save
            expect(event).to eq(false)
        end

        ########################################### EDGY ###########################################

        it "ensure presence of title" do 
            event = Event.new(event_title: "title", location: "location", description: "describe", start_time: Time.now, end_time: Time.now).save
            expect(event).to eq(true)
        end
    end
    
    
    context "association tests" do 
        ########################################### HAPPY ###########################################
        it "event has_many attendees" do 
            expect(Event.reflect_on_association(:attendees).macro).to eq(:has_many)
        end
        
        it "event has_many users" do 
            expect(Event.reflect_on_association(:users).macro).to eq(:has_many)
        end
        
        it "event has_many_through attendees" do 
            expect(Event.reflect_on_association(:users).options).to eq({:through => :attendees})
        end

        ########################################### EDGY ###########################################
        it "event do not has_many attendees" do 
            expect(Event.reflect_on_association(:attendees).macro).to_not eq(:belongs_to)
        end

        it "event do not has_many users" do 
            expect(Event.reflect_on_association(:users).macro).to_not eq(:belongs_to)
        end

        it "event do not has_many_through attendees" do 
            expect(Event.reflect_on_association(:users).options).to_not eq({:through => :users})
        end
    end
end
