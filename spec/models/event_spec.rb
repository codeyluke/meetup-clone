require 'rails_helper'

RSpec.describe Event, type: :model do
    content "validation tests" do 
        
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
