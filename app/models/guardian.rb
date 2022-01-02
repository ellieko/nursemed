class Guardian < ActiveRecord::Base
  has_and_belongs_to_many :students
  has_one :user, validate: true

  validates_associated :user

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
