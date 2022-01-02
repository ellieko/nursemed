class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :nurse, index: true, foreign_key: true
      t.references :student, index: true, foreign_key: true
      t.references :administrator, index: true, foreign_key: true
      t.references :guardian, index: true, foreign_key: true
      t.string :session_token, index: true
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
