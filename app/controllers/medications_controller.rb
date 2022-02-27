class MedicationsController < ApplicationController

  before_action :is_admin, :except => [:index, :show]
  after_action :access_denied, :only => [:edit, :update, :show, :destory]

  def index
    @medications = Medication.all
  end

  def show
    id = params[:id]
    @medication = Medication.find(id)
  end

  def new

  end

  def edit
    @medication = Medication.find params[:id]
  end

  def create
    @medication = Medication.create!(medication_params)
    flash[:notice] = "Successfully added medication."
    redirect_to medications_path
  end

  def update
    @medication = Medication.find params[:id]
    @medication.update_attributes!(medication_params)
    flash[:notice] = "Successfully updated medication."
    redirect_to medication_path(@medication)
  end

  def destroy
    @medication = Medication.find(params[:id])
    
    if @medication.medication_assignments.any?
      flash[:warning] = "Medication has assignments, cannot delete."
    else
      @medication.destroy
      flash[:notice] = "Removed medication."
    end

    redirect_to medications_path
  end

  private

  def medication_params
    params.require(:medication).permit(:name, :dosage, :true_name)
  end
end
