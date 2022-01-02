require 'spec_helper'
require 'rails_helper'

describe Student do
  it "can be valid" do
    student_dic = {:school_id => 0
    }
    student = Student.new(student_dic)
    expect(student).to be_valid
  end
  it "is not valid without a school" do
    student_dic = {}
    student = Student.new(student_dic)
    expect(student).to_not be_valid
  end
end
