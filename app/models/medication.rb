class Medication < ActiveRecord::Base
  has_many :medication_assignments
  has_many :students, :through => :medication_assignments
  has_and_belongs_to_many :adverse_effects

  validates :true_name, presence: true
  validates :name, presence: true
  validates :dosage, presence: true

  def display_name
    "#{name} #{dosage}"
  end
end
