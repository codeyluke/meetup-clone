class AttendeesController < ApplicationController
    def create 
        attendee = Attendee.new
        attendee.user_id = current_user.id 
        attendee.event_id = params[:event_id] 

        if !Attendee.where(user_id: attendee.user_id) && !Attendee.where(event_id: attendee.event_id)
            attendee.save 
            redirect_to event_path(id: attendee.event_id)
        else 
            # Trying the error to home first 
            redirect_to root_path
        end
        end
    end
end
