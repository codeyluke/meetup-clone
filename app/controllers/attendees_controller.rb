class AttendeesController < ApplicationController
    def create 
        attendee = Attendee.new
        attendee.user_id = current_user.id 
        attendee.event_id = params[:event_id] 
        attendee.save 
        redirect_to event_path(params[:event_id])
    end
   
    def destroy
        attendee = Attendee.find(params[:id]) 
        attendee.destroy
        redirect_to event_path(params[:event_id])
    end
end
