class CreateAdverseEffects < ActiveRecord::Migration
  def up
    create_table :adverse_effects do |t|
      t.string :description

      t.timestamps null: false
    end
  end
  def down
    drop_table :adverse_effects
  end
end
