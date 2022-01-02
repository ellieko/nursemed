class AddDetailsToStudents < ActiveRecord::Migration
  def change
    add_column :students, :first_name, :string
    add_column :students, :last_name, :string
    add_column :students, :birthdate, :date
    add_column :students, :guardian, :string
  end
end
