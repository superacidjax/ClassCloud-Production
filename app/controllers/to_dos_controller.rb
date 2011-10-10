class ToDosController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_my_students_and_class
  # GET /to_dos
  # GET /to_dos.json
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
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @to_dos }
    end
  end

  # GET /to_dos/1
  # GET /to_dos/1.json
  def show
    @to_do = ToDo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @to_do }
    end
  end

  # GET /to_dos/new
  # GET /to_dos/new.json
  def new
    @to_do = ToDo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @to_do }
    end
  end

  # GET /to_dos/1/edit
  def edit
    @to_do = ToDo.find(params[:id])
  end

  # POST /to_dos
  # POST /to_dos.json
  def create
    params[:to_do][:date] =  Time.new(params[:date][:year],params[:date][:month],params[:date][:day],params[:date][:hour],params[:date][:minute])

    @to_do = ToDo.new(params[:to_do])
   
    respond_to do |format|
      if @to_do.save
        format.html { redirect_to (class_room_to_dos_url(@class.id)), notice: 'To do was successfully created.' }
        format.json { render json: @to_do, status: :created, location: @to_do }
      else
        format.html { render action: "new" }
        format.json { render json: @to_do.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /to_dos/1
  # PUT /to_dos/1.json
  def update
    @to_do = ToDo.find(params[:id])

    respond_to do |format|
      if @to_do.update_attributes(params[:to_do])
        format.html { redirect_to (class_room_to_dos_url(@class.id)), notice: 'To do was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @to_do.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /to_dos/1
  # DELETE /to_dos/1.json
  def destroy
    to_do = ToDo.find(params[:id])
    to_do.destroy

    respond_to do |format|
      format.html { redirect_to (class_room_to_dos_url(@class.id)) }
      format.json { head :ok }
    end
  end

  private

  def get_my_students_and_class
    @class = current_user.class_rooms.find(params[:class_room_id])
    @students = @class.students
  end
end
