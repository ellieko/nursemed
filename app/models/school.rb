class School < ActiveRecord::Base
  has_many :students
  has_many :nurses

  validates :name, presence: true, length: {minimum: 3}
end
