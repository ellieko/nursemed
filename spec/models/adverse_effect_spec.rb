require 'spec_helper'
require 'rails_helper'

describe AdverseEffect do


  it "can be valid" do
    adverse_dic = {:description => "Bad"
    }
    adverse = AdverseEffect.new(adverse_dic)
    expect(adverse).to be_valid
  end

  it "is invalid without description" do
    adverse_dic = {    }
    adverse = AdverseEffect.new(adverse_dic)
    expect(adverse).to_not be_valid
  end
end
