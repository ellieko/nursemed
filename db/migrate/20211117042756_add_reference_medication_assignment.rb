class AddReferenceMedicationAssignment < ActiveRecord::Migration
  def change
    add_reference :students, :medication_assignment, foreign_key: true
  end
end
