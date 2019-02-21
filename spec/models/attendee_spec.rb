require 'rails_helper'

RSpec.describe Attendee, type: :model do
  context "association tests" do 
    ########################################### HAPPY ########################################### 
    it "Attendee belongs_to event" do 
      expect(Attendee.reflect_on_association(:event).macro).to eq(:belongs_to)
    end
    
    it "Attendee belongs_to user" do 
      expect(Attendee.reflect_on_association(:user).macro).to eq(:belongs_to)
    end
    
    ########################################### EDGY ###########################################

    it "Attendee do not belongs_to event" do 
      expect(Attendee.reflect_on_association(:event).macro).to_not eq(:has_many)
    end

    it "Attendee do not belongs_to user" do 
      expect(Attendee.reflect_on_association(:user).macro).to_not eq(:has_many)
    end
  end
end
