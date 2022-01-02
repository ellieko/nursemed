class RemoveDateFromMeetings < ActiveRecord::Migration
  def change
    remove_column :meetings, :date, :date
  end
end
