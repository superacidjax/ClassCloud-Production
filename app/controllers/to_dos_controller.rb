class ToDosController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_my_students_and_class

  def index
    if params[:selected_time].eql?("all")
      @to_dos = ToDo.all 
    elsif params[:selected_time].eql?("today")
      @to_dos = ToDo.today
    elsif params[:selected_time].eql?("tomorrow")
      time=Time.now+1.day
      @to_dos = ToDo.where("date like ?",time.strftime("%Y-%m-%d")+"%")
    elsif params[:selected_time].eql?("this week")
      @to_dos = ToDo.where("date <=? and date>=?",Time.now.end_of_week.strftime("%Y-%m-%d"),Time.now.strftime("%Y-%m-%d"))
    elsif params[:selected_time].eql?("next week")
      @to_dos = ToDo.where("date <=? and date>=?",Time.now.next_week.end_of_week.strftime("%Y-%m-%d"),Time.now.next_week.strftime("%Y-%m-%d"))
    elsif params[:selected_time].eql?("later")
      @to_dos = ToDo.where("date>=?",Time.now.next_week.end_of_week.strftime("%Y-%m-%d"))
    else
      @to_dos = ToDo.all
    end
  end

  def show
    @to_do = ToDo.find(params[:id])
  end

  def new
    @to_do = ToDo.new
  end

  def edit
    @to_do = ToDo.find(params[:id])
  end

  def create
    params[:to_do][:date] =  Time.new(params[:date][:year],params[:date][:month],params[:date][:day],params[:date][:hour],params[:date][:minute])

    @to_do = ToDo.new(params[:to_do])
   
    if @to_do.save
      redirect_to (class_room_to_dos_url(@class.id)), notice: 'To do was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @to_do = ToDo.find(params[:id])

    if @to_do.update_attributes(params[:to_do])
      redirect_to (class_room_to_dos_url(@class.id)), notice: 'To do was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    to_do = ToDo.find(params[:id])
    to_do.destroy

    redirect_to (class_room_to_dos_url(@class.id))
  end

  private

  def get_my_students_and_class
    @class = current_user.class_rooms.find(params[:class_room_id])
    @students = @class.students
  end
end
