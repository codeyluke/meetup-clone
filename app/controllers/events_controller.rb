class EventsController < ApplicationController
    before_action :require_login

    def index
        @events = Event.all 
    end
    
    def new 
        @event = Event.new
    end

    def create 
        event = Event.new(event_params)
        event.user_id = current_user.id
        if event.save
            flash[:notice] = "Event created"
            redirect_to event_path(event)
        else
            flash[:notice] = "Event didn't save"
            redirect_to root_path
        end
    end

    def edit 
        @event = Event.find(params[:id])
    end

    def show 
        @event = Event.find(params[:id])
        @attendee = Attendee.new
    end

    def update
        event = Event.find(params[:id])
        event.update(event_params)
        redirect_to event
        flash[:success] = "Event Edited"
    end

    def destroy
        @event = Event.find(params[:id])
        @event.destroy
        # change the route pathfor this after building the view page
        redirect_to root_path
    end

    private 
    def event_params 
        params.require(:event).permit(
            :event_title,
            :location,
            :date,
            :start_time, 
            :end_time, 
            :description
        )
    end
end
