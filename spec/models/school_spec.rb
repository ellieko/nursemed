require 'spec_helper'
require 'rails_helper'

describe School do
  it "can be valid" do
    school_dic = {:name => "Heyo"
    }
    school = School.new(school_dic)
    expect(school).to be_valid
  end
  it "is not valid without a name" do
    school_dic = {}
    school = School.new(school_dic)
    expect(school).to_not be_valid
  end
  it "is not valid without valid name" do
    school_dic = {:name => "H"
    }
    school = School.new(school_dic)
    expect(school).to_not be_valid
  end
end
