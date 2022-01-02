class CreateNurses < ActiveRecord::Migration
  def up
    create_table :nurses do |t|

      t.timestamps null: false
    end
  end
  def down
    drop_table :nurses
  end
end
