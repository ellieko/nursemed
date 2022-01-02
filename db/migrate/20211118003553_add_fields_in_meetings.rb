class AddFieldsInMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :error, :boolean, null: true
    add_column  :meetings, :errorType, :string, null: true
    add_column :meetings, :mitigation, :string, null: true
  end
end
