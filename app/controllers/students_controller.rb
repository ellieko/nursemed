class StudentsController < ApplicationController

  before_action :is_nurse_or_admin, except: [:show]
  before_action :is_nurse, except: [:transfer, :transfer_update, :show, :index]
  before_action :is_admin, only: [:transfer, :transfer_update]

  def new
    # default: render 'new' template
  end

  def create
    # create student and student user

    student_data = student_params
    student_data[:school_id] = @current_user.nurse.school_id
    @student = Student.new(student_data)
    user_data = user_params
    @student.user = User.new(user_data)
    @guardian = Guardian.new({})

    guardian_data = guardian_params
    @guardian.user = User.new(guardian_data)
    @student.guardians << @guardian

    if guardian_params[:email].strip.downcase == user_params[:email].strip.downcase
      @student.valid?
      error_message = ""
      @student.user.errors.full_messages.each do |error|
        error_message += error +". "
      end

      @guardian.user.errors.full_messages.each do |error|
        error_message += error +". "
      end
      flash[:warning] = error_message+"Emails need to be unique."

      redirect_to new_student_path
      return
    else
      begin
        @student.save!
      rescue ActiveRecord::RecordInvalid
        error_message = ""
        @student.user.errors.full_messages.each do |error|
          error_message += error +". "
        end
        @guardian.user.errors.full_messages.each do |error|
          error_message += error +". "
        end

        flash[:warning] = error_message

        redirect_to new_student_path
        return
      else
          UserMailer.welcome_email(@student.user, @student.user.password).deliver_later
      end

    end

    flash[:notice] = "#{@student.user.first_name} #{@student.user.last_name} was successfully created."
    redirect_to students_path
  end

  def edit
    @student = Student.find params[:id]
    @guardians = @student.guardians.first
  end

  def update
    @student = Student.find params[:id]
    @student.update_attributes!(student_params.delete_if {|key, value| value.nil? || value.empty?})
    @student.user.update_attributes!(user_params.delete_if {|key, value| value.nil? || value.empty?})
    @student.guardians.find(params[:guardians][:id]).user.update_attributes!(guardian_params)
    flash[:notice] = "Information of #{@student.user.first_name} #{@student.user.last_name} was successfully updated."
    redirect_to student_path(@student)
  end

  def index
    if @current_user.nurse
      @students = Student.where(school_id: @current_user.nurse.school_id)
    else
      @students = Student.all
    end
  end

  def show
    @student = nil
    id = params[:id] # retrieve student ID from URI route
    if @current_user.guardian
      student_list = @current_user.guardian.students.select {|student| student.id == id.to_i}
      if student_list.empty?
        redirect_to login_path
        return
      else
        @student = student_list[0]
      end
    elsif @current_user.student
      @student = @current_user.student
    end

    if not @student
      @student = Student.find(id)
    end
  end

  def transfer
    id = params[:id] # retrieve student ID from URI route
    @student = Student.find(id) # look up student by unique ID
    @schools = School.all
  end

  def transfer_update
    id = params[:id] # retrieve student ID from URI route
    @student = Student.find(id) # look up student by unique ID
    @student.school = School.find(params["school"])
    @student.save!
    redirect_to student_path(id)
  end

  private

  def student_params
    params.require(:student).permit(:birthdate, :school_id)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def guardian_params
    params.require(:guardians).permit(:first_name, :last_name, :email)
  end
end
