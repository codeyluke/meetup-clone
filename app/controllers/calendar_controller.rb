class CalendarController < ApplicationController
    def redirect 
        client = Signet::OAuth2::Client.new(client_options)
        cookies[:event_id] = params[:event_id]
        redirect_to client.authorization_uri.to_s
    end
    def callback
        client = Signet::OAuth2::Client.new(client_options)
        client.code = params[:code]
        
        response = client.fetch_access_token!
        
        session[:authorization] = response
        
        client.update!(session[:authorization])
        
        service = Google::Apis::CalendarV3::CalendarService.new
        service.authorization = client
        
        booked_event = Event.find(cookies[:event_id])
        
        byebug
        start_date = Date.parse(booked_event.start_time.strftime('%a, %d %b %Y'))
        end_date = Date.parse(booked_event.end_time.strftime('%a, %d %b %Y'))
    
        booked_event = Google::Apis::CalendarV3::Event.new({
          start: Google::Apis::CalendarV3::EventDateTime.new(date: start_date),
          end: Google::Apis::CalendarV3::EventDateTime.new(date: end_date),
          location: booked_event.location,
          summary: 'Your event is booked at '+ booked_event.location
        })
    
        service.insert_event(current_user.email, booked_event)
    
        redirect_to user_path(current_user.id)
        flash[:primary] = "Trip added to your calendar!"
    end
    
    private
    def client_options
        {
            client_id: ENV["GOOGLE_APP_ID"],
            client_secret: ENV["GOOGLE_APP_SECRET"],
            authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
            token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
            scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
            redirect_uri: callback_url
        }
    end
end
