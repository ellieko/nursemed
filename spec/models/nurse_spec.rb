require 'spec_helper'
require 'rails_helper'

describe Nurse do
  it "can be valid" do
    nurse_dic = {:school_id => 0
    }
    nurse = Student.new(nurse_dic)
    expect(nurse).to be_valid
  end
  it "is not valid without a school" do
    nurse_dic = {}
    nurse = Student.new(nurse_dic)
    expect(nurse).to_not be_valid
  end
end
