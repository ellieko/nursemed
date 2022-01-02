class UpdateMeetingsWithDetails < ActiveRecord::Migration
  def change
    add_column :meetings, :start, :datetime
    add_column :meetings, :log, :string, :default => 'false'
  end
end
