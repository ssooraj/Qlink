class EventsController < ApplicationController
require 'google/api_client'
require 'rubygems'
before_filter :authorize_user!
  def index
        @events = Event.scoped 
        respond_to do |format|
        format.html
        format.json { render :json =>  @events }
            end
  end 

  def invitepeople
    eventid = params[:id]
    session[:@event] = Event.find(eventid)
    @eventemail = Eventemail.find_by_sql("select email from eventemails where event_id = '#{eventid}'")
  end

  def save_eventemail
    params[:eventemail][:event_id]=params[:id]

    eventmail = Eventemail.create(params[:eventemail])
    if eventmail.save
     event = {
            'summary' => session[:@event].title,
            'description' => session[:@event].description,
              'start' => {
    'dateTime' => session[:@event].start.to_datetime
  },
  'end' => {
    'dateTime' =>session[:@event].endtime.to_datetime
  },
  'attendees' => [
    {
      'email' => eventmail.email
    },
  ],
}
@client = client_call()          
            @service = @client.discovered_api('calendar', 'v3')
result = @client.execute(:api_method => @service.events.insert,
                        :parameters => {'calendarId' => 'primary'},
                        :body => JSON.dump(event),
                        :headers => {'Content-Type' => 'application/json'})
    redirect_to :controller => "events", :action => "invitepeople", :id => session[:@event].id
  else
           flash[:alert] = "Invalid emailid!"
           redirect_to :controller => "events", :action => "invitepeople", :id => session[:@event].id
           end

  end
  def save_event
    session[:@event]= Event.create(params[:event])
    session[:@event].update_attributes(:user_id => current_user.id)
    Userevent.create(:eventid => session[:@event].id,:title => session[:@event].title,:description =>session[:@event].description,:start => session[:@event].start,:endtime => session[:@event].endtime,:user_id => current_user.id)
        if session[:@event].save
          event = {
            'summary' => session[:@event].title,
             'description' => session[:@event].description,
              'start' => {
    'dateTime' => session[:@event].start.to_datetime
  },
  'end' => {
    'dateTime' =>session[:@event].endtime.to_datetime
  },
}

@client = client_call()            

            @service = @client.discovered_api('calendar', 'v3')
result = @client.execute(:api_method => @service.events.insert,
                        :parameters => {'calendarId' => 'primary'},
                        :body => JSON.dump(event),
                        :headers => {'Content-Type' => 'application/json'})
               event = Event.find(session[:@event].id)
               event.eventId = result.data.id
               event.save
               flash[:alert] = "Event added!"
               redirect_to :controller => "events", :action => "invitepeople", :id => session[:@event].id
          else
           flash[:alert] = "Error while adding event!"
           redirect_to events_path
           end
    end
   def showcalendar
   end   
   def update_event
    @event = Event.find(params[:id])
   end
   def updatesave_event
     @event = Event.find(params[:id])
     @event.update_attributes(:title => params[:event][:title],:description => params[:event][:description],:start => params[:event][:start],:endtime => params[:event][:endtime])
     @event = Event.find(params[:id])
 @client = client_call()         
            @service = @client.discovered_api('calendar', 'v3')
    result = @client.execute(:api_method => @service.events.get,
                        :parameters => {'calendarId' => 'primary', 'eventId' => params[:eventid]})
event = result.data
 event = {
            'summary' => @event.title,
             'description' => @event.description,
              'start' => {
    'dateTime' => @event.start.to_datetime
  },
  'end' => {
    'dateTime' =>@event.endtime.to_datetime
  },
 
}
result = @client.execute(:api_method => @service.events.update,
                        :parameters => {'calendarId' => 'primary', 'eventId' => params[:eventid]},
                        :body_object => event,
                        :headers => {'Content-Type' => 'application/json'})

     redirect_to firstpage_events_path
   end
   def firstpageremove
        @event = Event.find(params[:id]) 
        @client = client_call()  
          @service = @client.discovered_api('calendar', 'v3')
           result = @client.execute(:api_method => @service.events.delete,
                        :parameters => {'calendarId' => 'primary', 'eventId' => @event.eventId})
         Userevent.delete_all(:eventid => params[:id])
         Event.delete(params[:id])
     redirect_to firstpage_events_path
   end
   def firstpage    
      @client = client_call()
     #  render :json => {:data => @client}
            @service = @client.discovered_api('calendar', 'v3')
            result = @client.execute(
             :api_method => @service.calendar_list.list,
             :parameters => {},
             :headers => {'Content-Type' => 'application/json'})
            page_token = nil
@result = @result = @client.execute(:api_method => @service.events.list,
                                 :parameters => {'calendarId' => 'primary'})   
while true
                 events = @result.data.items

           if !(page_token = result.data.next_page_token)
              break
           end
            @result = @result = @client.execute(:api_method => @service.events.list,

                                   :parameters => {'calendarId' => 'primary', 'pageToken' => page_token})   
        end
            length = @result.data.items.length
            to_check_presenceofuser = Event.find_by_user_id(current_user.id)
             for i in (0..length-1)
              to_check_presenceofevent = Event.find_by_eventId(@result.data.items[i].id)
              if(to_check_presenceofevent.nil? ||to_check_presenceofuser.nil?)
              @event = Event.create(:title => @result.data.items[i].summary, :description => @result.data.items[i].description, :start => @result.data.items[i].start.dateTime,:endtime => @result.data.items[i].end.dateTime,:eventId => @result.data.items[i].id,:user_id => current_user.id,:flag =>"false")
            end      
       end
    for i in (0..length-1)
        event = Event.find_by_sql("select * from events where user_id = #{current_user.id}")  
           event.each do |event|
             if(event.eventId == @result.data.items[i].id)
             event.flag = 'true'
             event.save
            end
          end
         end
    Event.where(:flag => 'false').destroy_all
    Event.update_all(:flag => 'false')   
  @data_to_display = Event.find_by_sql("select * from events where user_id = #{current_user.id}").reverse
end
end
