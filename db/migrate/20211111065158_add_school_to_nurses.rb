class AddSchoolToNurses < ActiveRecord::Migration
  def change
    add_reference :nurses, :school, index: true, foreign_key: true
  end
end
