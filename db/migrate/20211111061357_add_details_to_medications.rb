class AddDetailsToMedications < ActiveRecord::Migration
  def change
    add_column :medications, :name, :string
    add_column :medications, :dosage, :string
    add_column :medications, :true_name, :string
  end
end
