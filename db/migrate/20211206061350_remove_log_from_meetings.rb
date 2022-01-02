class RemoveLogFromMeetings < ActiveRecord::Migration
  def change
    remove_column :meetings, :log, :boolean
  end
end
