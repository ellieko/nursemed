class AddLogToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :log, :boolean, :default => false
  end
end
