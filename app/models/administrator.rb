class Administrator < ActiveRecord::Base
  has_one :user
end
