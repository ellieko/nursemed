class CreateJoinTableGuardiansStudents < ActiveRecord::Migration
  def change
    create_join_table :guardians, :students do |t|
      # t.index [:guardian_id, :student_id]
      # t.index [:student_id, :guardian_id]
    end
  end
end
