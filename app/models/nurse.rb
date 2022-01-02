class Nurse < ActiveRecord::Base
  has_many :meetings
  has_many :students
  has_many :medication_assignments
  has_one :user, validate: true
  belongs_to :school

  validates :school_id, presence: true

end
