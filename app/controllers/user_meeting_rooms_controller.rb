class UserMeetingRoomsController < ApplicationController
  before_filter :authenticate_user!
  
  