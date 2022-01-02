class AddColumnsToMedicationAssignment < ActiveRecord::Migration
  def change
    add_column :medication_assignments, :frequency, :string
    add_column :medication_assignments, :amount, :string
    add_column :medication_assignments, :description, :string
  end
end
