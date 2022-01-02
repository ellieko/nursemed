class CreateMedications < ActiveRecord::Migration
  def up
    create_table :medications do |t|

      t.timestamps null: false
    end
  end
  def down
    drop_table :medications
  end
end
