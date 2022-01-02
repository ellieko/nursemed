require 'spec_helper'
require 'rails_helper'

describe MedicationAssignment do
  it "can be valid" do
    med_dic = {:nurse_id => 0,
                   :student_id => 0,
                   :medication_id => 0,
                   :start_date => "10-9-2010",
                   :end_date => "10-10-2010"
    }
    med_ass = MedicationAssignment.new(med_dic)
    expect(med_ass).to be_valid
  end
  it "is not valid without a nurse" do
    med_dic = {:student_id => 0,
               :medication_id => 0,
               :start_date => "10-9-2010",
               :end_date => "10-10-2010"
    }
    med_ass = MedicationAssignment.new(med_dic)
    expect(med_ass).to_not be_valid
  end
  it "is not valid without a student" do
    med_dic = {:nurse_id => 0,
               :medication_id => 0,
               :start_date => "10-9-2010",
               :end_date => "10-10-2010"
    }
    med_ass = MedicationAssignment.new(med_dic)
    expect(med_ass).to_not be_valid
  end
  it "is not valid without a medication" do
    med_dic = {:nurse_id => 0,
               :student_id => 0,
               :start_date => "10-9-2010",
               :end_date => "10-10-2010"
    }
    med_ass = MedicationAssignment.new(med_dic)
    expect(med_ass).to_not be_valid
  end
  it "is not valid without a start date" do
    med_dic = {:nurse_id => 0,
               :student_id => 0,
               :medication_id => 0,
               :end_date => "10-10-2010"
    }
    med_ass = MedicationAssignment.new(med_dic)
    expect(med_ass).to_not be_valid
  end
  it "is not valid without a end date" do
    med_dic = {:nurse_id => 0,
               :student_id => 0,
               :medication_id => 0,
               :start_date => "10-9-2010"
    }
    med_ass = MedicationAssignment.new(med_dic)
    expect(med_ass).to_not be_valid
  end
end
