class EventsController < ApplicationController
    before_action :require_login

    def index
        @events = Event.all        
        @search = params["search"]
        if @search.present?
            if @search["event_title"].present?
                @event_title = @search["event_title"]
                @events = Event.where("event_title ILIKE ?", "%#{@event_title}%")
            end
            if @search["description"].present?
                @description = @search["description"]
                @events = Event.where("description ILIKE ? ", "%#{@description}%")    
            end
            if @search["date"].present?
                @date = @search["date"]
                @events = Event.where(date: "#{@date}")
                if !@events.present? 
                    @events = Event.all
                    @attendees = Attendee.all
                    @ten_days_before = (@date.to_date - 10).to_s
                    @ten_days_after = (@date.to_date + 10).to_s
                    @events = Event.where(date: "#{@ten_days_before}".."#{@ten_days_after}" )
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
