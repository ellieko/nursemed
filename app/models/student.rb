class Student < ActiveRecord::Base
  has_many :meetings
  has_many :medication_assignments, dependent: :destroy
  has_and_belongs_to_many :guardians, validate: true
  has_one :user, validate: true
  belongs_to :school

  accepts_nested_attributes_for :guardians

  validates :school_id, presence: true

  def first_name
    user.first_name
  end
  def last_name
    user.last_name
  end
  def email
    user.email
  end
end
