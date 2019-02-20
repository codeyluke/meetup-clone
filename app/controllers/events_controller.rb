class EventsController < ApplicationController
    before_action :require_login
    
    def index
        @events = Event.all        
        @search = params["search"]
        if @search.present?
            if @search["event_title"].present?
                @events = Event.search_event_title(@search)
            end
            if @search["description"].present?
                @events = Event.search_event_description(@search)    
            end
            if @search["date"].present?
                @events = Event.search_event_date(@search)
                if !@events.present?
                   @events = Event.search_event_other_dates(@search) 
                end
            end
        end
    end
    
    def new 
        @event = Event.new
    end

    def create 
        event = Event.new(event_params)
        event.creator_id = current_user.id
        event.start_date = event.start_time.strftime("%Y-%m-%d").to_date
        event.end_date = event.end_time.strftime("%Y-%m-%d").to_date
        
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
        @attendees = Attendee.all
        @user = User.find(current_user.id)
        @host = User.find(@event.creator_id)
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
        # change the route path for this after building the view page
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
