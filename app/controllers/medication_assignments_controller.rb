class MedicationAssignmentsController < ApplicationController
  before_action :get_student
  before_action :is_nurse, except: [:index, :show]
  before_action :has_access_to_assignment, only: [:index, :show]

  def index
    @medication_assignments = @student.medication_assignments
  end

  def show
    @medication_assignment = MedicationAssignment.find params[:id]
    @medication = Medication.find(@medication_assignment.medication_id)
  end

  def new
  end

  def edit
    @medication_assignment = MedicationAssignment.find params[:id]
  end

  def create
    @medication_assignment = MedicationAssignment.create!(medication_assignments_params)
    flash[:notice] = "Successfully assigned medication."
    redirect_to student_medication_assignments_path
  end

  def update
    @medication_assignment = MedicationAssignment.find params[:id]
    @medication_assignment.update_attributes!(medication_assignments_params)
    flash[:notice] = "Successfully updated medication assignment."
    redirect_to student_medication_assignment_path(@student, @medication_assignment)
  end

  def destroy
    @medication_assignment = MedicationAssignment.find(params[:id])
    @medication_assignment.destroy
    flash[:notice] = "Stopped medication."
    redirect_to student_medication_assignments_path
  end

  protected
  def has_access_to_assignment
    if @current_user.nurse or @current_user.administrator

    elsif (@current_user.student and @current_user.student.id == @student.id)

    elsif (@current_user.guardian and @student.guardians.include?(@current_user.guardian))

    else
      redirect_to login_path
    end
  end

  private

  def get_student
    @student = Student.find(params[:student_id])
  end

  def medication_assignments_params
    params.require(:medication_assignment).permit(:student_id, :nurse_id, :medication_id, :start_date, :end_date, :frequency, :amount, :description)
  end
end
