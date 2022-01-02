class UpdateStudentsWithIDs < ActiveRecord::Migration
  def change
    change_table :students do |t|
      t.remove :first_name, :last_name, :guardian
    end
    add_reference :students, :school, foreign_key: true
  end
end
