class MedicationAssignment < ActiveRecord::Base
  belongs_to :nurse
  belongs_to :student
  belongs_to :medication

  validates :student_id, presence: true
  validates :nurse_id, presence: true
  validates :medication_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

end
