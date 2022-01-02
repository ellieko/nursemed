class Meeting < ActiveRecord::Base
  belongs_to :nurse
  belongs_to :student

  validates :student_id, presence: true
  validates :nurse_id, presence: true
  validates :start, presence: true
end
