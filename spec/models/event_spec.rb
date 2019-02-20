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

    context "custom method" do 
        ########################################### HAPPY ###########################################
        
        let (:params_1) {{event_title: "title_1", location: "location_1", description: "describe_1", start_time: Time.now, end_time: Time.now}}
        let (:params_2) {{event_title: "title_2", location: "location_2", description: "describe_2", start_time: Time.now, end_time: Time.now}} 
        
        before :each do 
            ActiveRecord::Base.connection.reset_pk_sequence!(:events) 
        end

        it "#search_event_title(search)" do 
            event_1 = Event.new(params_1).save
            event_2 = Event.new(params_2).save
            event = Event.where("event_title ILIKE ? ", "title_1").first.event_title
            expect(event).to eq("title_1")
        end

        ########################################### EDGY ###########################################

   
    end
end
