class CreateMeetings < ActiveRecord::Migration
  def up
    create_table :meetings do |t|
      t.references :nurse, index: true, foreign_key: true
      t.references :student, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
  def down
    drop_table :meetings
  end
end
