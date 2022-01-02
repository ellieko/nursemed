class AdverseEffect < ActiveRecord::Base
  has_and_belongs_to_many :medications
  validates :description, presence: true
end
