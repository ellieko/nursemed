class CreateMedicationAssignments < ActiveRecord::Migration
  def up
    create_table :medication_assignments do |t|
      t.references :nurse, index: true, foreign_key: true
      t.references :student, index: true, foreign_key: true
      t.references :medication, index: true, foreign_key: true
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
  def down
    drop_table :medication_assignments
  end
end
