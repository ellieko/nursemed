class AddDetailsToMeetings < ActiveRecord::Migration
  def change
    add_column :meetings, :info, :string
  end
end
