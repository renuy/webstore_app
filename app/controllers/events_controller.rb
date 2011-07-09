class EventsController < ApplicationController
  # GET /events
  # GET /events.xml
  def index
    redirect_to powai_path

  end

  # GET /events/1
  # GET /events/1.xml
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html { render 'show', :layout=>'blank'}# show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = Event.new

    respond_to do |format|
      format.html { render 'new', :layout=>'blank'}# new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    redirect_to powai_path
  end

  # POST /events
  # POST /events.xml
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        EventMailer.registration_confirmation(@event).deliver
        format.html { redirect_to(@event, :notice => 'Thank you for your interest. We shall get back to you.') }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" ,:layout=>'blank'}
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  
end
