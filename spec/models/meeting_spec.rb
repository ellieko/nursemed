require 'spec_helper'
require 'rails_helper'

describe Meeting do
  it "can be valid" do
    meeting_dic = {:nurse_id => 0,
               :student_id => 0,
               :date => "10-10-2010"
    }
    meeting = Meeting.new(meeting_dic)
    expect(meeting).to be_valid
  end
  it "is not valid without a nurse" do
    meeting_dic = {:student_id => 0,
               :date => "10-10-2010"
    }
    meeting = Meeting.new(meeting_dic)
    expect(meeting).to_not be_valid
  end

  it "is not valid without a student" do
    meeting_dic = {:nurse_id => 0,
                   :date => "10-10-2010"
    }
    meeting = Meeting.new(meeting_dic)
    expect(meeting).to_not be_valid
  end
  it "is not valid without a date" do
    meeting_dic = {:student_id => 0,
                   :nurse_id => 0
    }
    meeting = Meeting.new(meeting_dic)
    expect(meeting).to_not be_valid
  end
end
