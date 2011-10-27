class UserMeetingRoomsController < ApplicationController
  # GET /user_meeting_rooms
  # GET /user_meeting_rooms.json
  def index
    @user_meeting_rooms = UserMeetingRoom.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_meeting_rooms }
    end
  end

  # GET /user_meeting_rooms/1
  # GET /user_meeting_rooms/1.json
  def show
    @user_meeting_room = UserMeetingRoom.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_meeting_room }
    end
  end

  # GET /user_meeting_rooms/new
  # GET /user_meeting_rooms/new.json
  def new
    @user_meeting_room = UserMeetingRoom.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_meeting_room }
    end
  end

  # GET /user_meeting_rooms/1/edit
  def edit
    @user_meeting_room = UserMeetingRoom.find(params[:id])
  end

  # POST /user_meeting_rooms
  # POST /user_meeting_rooms.json
  def create
    @user_meeting_room = UserMeetingRoom.new(params[:user_meeting_room])

    respond_to do |format|
      if @user_meeting_room.save
        format.html { redirect_to @user_meeting_room, notice: 'User meeting room was successfully created.' }
        format.json { render json: @user_meeting_room, status: :created, location: @user_meeting_room }
      else
        format.html { render action: "new" }
        format.json { render json: @user_meeting_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_meeting_rooms/1
  # PUT /user_meeting_rooms/1.json
  def update
    @user_meeting_room = UserMeetingRoom.find(params[:id])

    respond_to do |format|
      if @user_meeting_room.update_attributes(params[:user_meeting_room])
        format.html { redirect_to @user_meeting_room, notice: 'User meeting room was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_meeting_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_meeting_rooms/1
  # DELETE /user_meeting_rooms/1.json
  def destroy
    @user_meeting_room = UserMeetingRoom.find(params[:id])
    @user_meeting_room.destroy

    respond_to do |format|
      format.html { redirect_to user_meeting_rooms_url }
      format.json { head :ok }
    end
  end
end
