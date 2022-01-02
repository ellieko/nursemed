class CreateJoinTableAdverseEffectsMedications < ActiveRecord::Migration
  def change
    create_join_table :adverse_effects, :medications do |t|
      # t.index [:adverse_effect_id, :medication_id]
      # t.index [:medication_id, :adverse_effect_id]
    end
  end
end
