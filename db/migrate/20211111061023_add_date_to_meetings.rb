class AddDateToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :date, :date
  end
end
