require 'spec_helper'
require 'rails_helper'

describe MedicationsController do

  before :each do
    @controller = SessionsController.new
    post :create, {"session" => {"email" => "hell@bear.com", "password" => "12345"}}

    @controller = MedicationsController.new
  end

  describe 'new medication form' do
    it 'should show the form for a new medication' do
      get(:new, params: {})
      expect(response).to render_template('new')
    end
  end

  describe 'create medication' do
    it 'should create medication successfully' do
      medication = double('Medication', :name => 'Tylenol', :dosage => '80 mg', :true_name => 'Acetaminophen')
      allow(Medication).to receive(:create!).and_return (medication)
      allow_any_instance_of(MedicationsController).to receive(:medication_params).and_return (medication)

      post :create, :medication => medication
      expect(response).to redirect_to(medications_path)
    end
  end

  describe 'list all medications' do
    it 'should find and list all medications' do
      fake_results = [double('Medication'), double('Medication')]
      expect(Medication).to receive(:all).and_return(fake_results)
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'edit a medication' do
    it 'should show the form to edit a medication' do
      medication = double('Medication', :id => 1, :name => 'Tylenol', :dosage => '80 mg', :true_name => 'Acetaminophen')
      allow(Medication).to receive(:find).with('1').and_return(medication)
      get :edit, :id => '1'
      expect(response). to render_template('edit')
    end
  end

  describe 'update a medication' do
    it 'should save the updated medication info' do
      medication = double('Medication', :id => 1, :name => 'Tylenol', :dosage => '80 mg', :true_name => 'Acetaminophen')
      allow(Medication).to receive(:find).with('1').and_return(medication)
      allow(medication).to receive(:update_attributes!)
      allow_any_instance_of(MedicationsController).to receive(:medication_params).and_return (medication)
      put :update, :id => '1', :medication => medication
      expect(response).to redirect_to(medication_path(medication))
    end
  end

  describe 'find a medication' do
    it 'should show the medication detail' do
      medication = double('Medication', :id => 1, :name => 'Tylenol', :dosage => '80 mg', :true_name => 'Acetaminophen')
      expect(Medication).to receive(:find).with('1').and_return(medication)
      get :show, :id => '1'
      expect(response).to render_template('show')
    end
  end

  describe 'delete a medication' do
    it 'should delete a medication' do
      medication = double('Medication', :id => 1, :name => 'Tylenol', :dosage => '80 mg', :true_name => 'Acetaminophen')
      expect(Medication).to receive(:find).with('1').and_return(medication)
      expect(medication).to receive(:destroy)
      expect(medication).to receive(:medication_assignments).and_return([])
      delete :destroy, :id => '1'
      expect(response).to redirect_to(medications_path)
    end

    it 'should show correct flash message' do
      medication = double('Medication', :id => 1, :name => 'Tylenol', :dosage => '80 mg', :true_name => 'Acetaminophen')
      expect(Medication).to receive(:find).with('1').and_return(medication)
      expect(medication).to receive(:destroy)
      expect(medication).to receive(:medication_assignments).and_return([])
      delete :destroy, :id => '1'
      expect(flash[:notice]).to eq("Removed medication.")
    end

    it 'should not delete medication with med assignments' do
      medication = double('Medication', :id => 1, :name => 'Tylenol', :dosage => '80 mg', :true_name => 'Acetaminophen')
      med_assignment = [double('MedicationAssignment', :medication => medication)]
      expect(Medication).to receive(:find).with('1').and_return(medication)
      expect(medication).to_not receive(:destroy)
      expect(medication).to receive(:medication_assignments).and_return(med_assignment)
      delete :destroy, :id => '1'
      expect(response).to redirect_to(medications_path)
    end
  end

  describe 'should redirect as appropriate' do
    it 'new should redirect non-admin' do

      @controller = SessionsController.new
      post :create, {"session" => {"email" => "inco@gnito.com", "password" => "12345"}}
      @controller = MedicationsController.new

      get :new
      expect(response).to redirect_to('/login')
    end
    it 'new should allow admin' do

      get :new
      expect(response).to have_http_status(:success)
    end
  end

end