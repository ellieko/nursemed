class NursesController < ApplicationController

  before_action :is_nurse_or_admin
  before_action :is_admin, except: [:show]

  def new
    # default: render 'new' template
  end

  def create
    @nurse = Nurse.new(nurse_params)
    user_data = user_params
    @nurse.user = User.new(user_data)

    begin
      @nurse.save!
    rescue ActiveRecord::RecordInvalid
      error_message = ""
      @nurse.user.errors.full_messages.each do |error|
        error_message += error +". "
      end

      redirect_to new_nurse_path
      return
    else
      UserMailer.welcome_email(@nurse.user, @nurse.user.password).deliver_later
    end

    flash[:notice] = "#{@nurse.user.first_name} #{@nurse.user.last_name} was successfully created."
    redirect_to nurses_path
  end

  def edit
    @nurse = Nurse.find params[:id]

  end

  def update
    @nurse = Nurse.find params[:id]
    @nurse.update_attributes!(nurse_params.delete_if {|key, value| value.nil? || value.empty?})
    @nurse.user.update_attributes!(user_params.delete_if {|key, value| value.nil? || value.empty?})
    flash[:notice] = "Information of #{@nurse.user.first_name} #{@nurse.user.last_name} was successfully updated."
    redirect_to nurses_path
  end

  def destroy
  end

  def index
    @nurses = Nurse.all
  end

  def show
    if @current_user.nurse
      @nurse = @current_user.nurse
    else
      @nurse = Nurse.find(params[:id])
    end

    @meetings = @nurse.meetings.where(log: 'false').order(start: :desc)
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def nurse_params
    params.require(:nurse).permit(:first_name, :last_name, :school_id)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
