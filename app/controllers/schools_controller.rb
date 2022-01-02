class SchoolsController < ApplicationController

  before_action :is_admin

  def index
    @schools = School.all
  end

  def show
    id = params[:id]
    @school = School.find(id)
  end

  def new

  end

  def edit
    @school = School.find params[:id]
  end

  def create
    @school = School.create!(school_params)
    flash[:notice] = "Successfully added school"
    redirect_to schools_path
  end

  def update
    @school = School.find params[:id]
    @school.update_attributes!(school_params)
    flash[:notice] = "Successfully updated school"
    redirect_to school_path(@school)
  end

  def destroy
    @school = School.find(params[:id])

    if @school.students.any?
      flash[:warning] = "School has students, cannot delete."
    elsif @school.nurses.any?
      flash[:warning] = "School has nurses, cannot delete."
    else
      @school.destroy
      flash[:notice] = "Removed school."
    end

    redirect_to schools_path
  end

  private

  def school_params
    params.require(:school).permit(:name)
  end
end
