class MeetingsController < ApplicationController

  before_action :is_nurse, except: [:show, :index]
  before_action :is_nurse_or_admin, only: [:index]
  before_action :has_access_to_meeting, only: [:show]

  def new
    @nurse = @current_user.nurse
    @students = Student.where(school_id: @nurse.school_id)
  end

  def create
    @nurse = @current_user.nurse
    d = DateTime.civil(meeting_params["start(1i)"].to_i,meeting_params["start(2i)"].to_i,meeting_params["start(3i)"].to_i,
                       meeting_params["start(4i)"].to_i,meeting_params["start(5i)"].to_i)
    if @nurse.meetings.where(start: meeting_params[:start]).empty? && Date.today < d
      begin
        @student = Student.find(meeting_params[:student_id])
        @meeting = Meeting.new(meeting_params)
        #@meeting = Meeting.new({nurse_id: meeting_params[:nurse_id], student_id: meeting_params[:student_id], start: d, info: meeting_params[:info]})
        @meeting.student = @student
        @meeting.save!
        flash[:notice] = "A new meeting was successfully scheduled."
        redirect_to nurse_path(@nurse)
      rescue ActiveRecord::RecordNotFound
        flash[:notice] = "You must select a student to add a schedule. Please select one below."
        redirect_to new_nurse_meeting_path
      end
    else
      flash[:notice] = "The seleced time slot is not available. Please choose another time."
      redirect_to new_nurse_meeting_path
    end
  end

  def log
    @nurse = @current_user.nurse
    @meeting = Meeting.find(params[:id])
    if @meeting.log == 'true'
      flash[:notice] = "Meeting already has been logged. You cannot relog the meeting."
      redirect_to nurse_meeting_path(@nurse, @meeting)
    else
      @meeting.log = 'true'
      @meeting.save!
      redirect_to nurse_path(@nurse)
    end
  end

  def edit
    @nurse = @current_user.nurse
    @meeting = Meeting.find params[:id]
  end

  def update
    @nurse = @current_user.nurse
    @meeting = Meeting.find params[:id]
    @meeting.update_attributes!(meeting_params)
    flash[:notice] = "Meeting Details was successfully updated."
    redirect_to nurse_meeting_path(@nurse, @meeting)
  end

  def destroy
    @nurse = @current_user.nurse
    @meeting = Meeting.find(params[:id])
    if @meeting.log == 'true'
      flash[:notice] = "Meeting already has been canceled. You cannot relog the meeting."
      redirect_to nurse_meeting_path(@nurse, @meeting)
    else
      @meeting.log = 'canceled'
      @meeting.save!
      flash[:notice] = "The seleceted schedule was successfully canceled."
      redirect_to nurse_path(@nurse)
    end
  end

  def index
    if @current_user.nurse
      @nurse = @current_user.nurse
    else
      @nurse = Nurse.find(params[:nurse_id])
    end
    @meetings = @nurse.meetings.where('start < ?', Date.today).order(start: :desc)
  end

  def error
    @meeting = Meeting.find(params[:id])
  end

  def adderror
    @meeting = Meeting.find(params[:id])
    @meeting.error = true
    @meeting.update_attributes!(meeting_params)
    flash[:notice] = "Error Recorded"
    redirect_to nurse_path(params[:nurse_id])
  end

  def show
    id = params[:id] # retrieve student ID from URI route
    @meeting = Meeting.find(id)
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def meeting_params
    params[:meeting][:nurse_id] = params[:nurse_id]
    params.require(:meeting).permit(:student_id, :start, :info, :nurse_id)
  end

  protected

  def has_access_to_meeting
    @meeting = Meeting.find(params[:id])
    if @current_user.nurse or @current_user.administrator

    elsif (@current_user.student and @current_user.student.id == @meeting.student_id)

    elsif (@current_user.guardian and @meeting.student.guardians.include?(@current_user.guardian))

    else
      redirect_to login_path
    end
  end
end
