require 'spec_helper'
require 'rails_helper'

describe Medication do
  describe 'getting display name' do
    it 'should correctly create display name' do
      medication_1 = Medication.new(:name => 'Tylenol', :dosage => '80 mg', :true_name => 'Acetaminophen')
      expect(medication_1.display_name).to eq("#{medication_1.name} #{medication_1.dosage}")
    end
  end
  it "can be valid" do
    med_dic = {:name => "Turbo Medz",
                   :true_name => "Medz",
                   :dosage => "2mg"
    }
    med = Medication.new(med_dic)
    expect(med).to be_valid
  end
  it "is invalid without dosage" do
    med_dic = {:name => "Turbo Medz",
               :true_name => "Medz"
    }
    med = Medication.new(med_dic)
    expect(med).to_not be_valid
  end

  it "is invalid without true name" do
    med_dic = {:name => "Turbo Medz",
               :dosage => "2mg"
    }
    med = Medication.new(med_dic)
    expect(med).to_not be_valid
  end

  it "is invalid without name" do
    med_dic = {:true_name => "Medz",
               :dosage => "2mg"
    }
    med = Medication.new(med_dic)
    expect(med).to_not be_valid
  end

end
