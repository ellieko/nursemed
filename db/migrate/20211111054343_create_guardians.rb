class CreateGuardians < ActiveRecord::Migration
  def change
    create_table :guardians do |t|

      t.timestamps null: false
    end
  end
end
