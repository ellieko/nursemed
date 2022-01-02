require 'spec_helper'
require 'rails_helper'

describe MedicationAssignmentsController do

  before :each do
    @controller = SessionsController.new
    post :create, {"session" => {"email" => "inco@gnito.com", "password" => "12345"}}

    @controller = MedicationAssignmentsController.new
  end

  describe 'new medication assignment for a student' do
    it 'should show the form for user to assign medication to student' do
      get :new, :student_id => 1
      expect(response).to render_template('new')
    end
  end

  describe 'create a medication assignment for a student' do
    it 'should create medication assignment successfully' do
      medication_assignment = double('MedicationAssignment', :medication_id => 1, :student_id => 1, :nurse_id => 1)
      allow(MedicationAssignment).to receive(:create!).and_return (medication_assignment)
      allow_any_instance_of(MedicationAssignmentsController).to receive(:medication_assignments_params).and_return (medication_assignment)
      post :create, :student_id => 1, :medication_assignment => medication_assignment
      expect(response).to redirect_to(student_medication_assignments_path)
    end
  end

  describe 'list all medication assignments for a student' do
    it 'should find and list all medication assignments' do
      fake_results = [double('MedicationAssignment'), double('MedicationAssignment')]
      expect_any_instance_of(Student).to receive(:medication_assignments).and_return(fake_results)
      get :index, :student_id => 1
      expect(response).to render_template('index')
    end
  end

  describe 'edit a medication assignment for a student' do
    it 'should show the form to edit medication assignment' do
      medication_assignment = double('MedicationAssignment', :id => '1', :medication_id => 1, :student_id => 1, :nurse_id => 1)
      allow(MedicationAssignment).to receive(:find).with('1').and_return(medication_assignment)
      get :edit, :student_id => 1, :id => '1'
      expect(response). to render_template('edit')
    end
  end

  describe 'update a medication assignment for a student' do
    it 'should save the updated student info' do
      medication_assignment = double('MedicationAssignment', :id => '1', :medication_id => 1, :student_id => 1, :nurse_id => 1)
      allow(MedicationAssignment).to receive(:find).with('1').and_return(medication_assignment)
      allow(medication_assignment).to receive(:update_attributes!)
      allow_any_instance_of(MedicationAssignmentsController).to receive(:medication_assignments_params).and_return (medication_assignment)
      put :update, :student_id => 1, :id => '1', :medication_assignment => medication_assignment
      expect(response).to redirect_to(student_medication_assignment_path(1, medication_assignment))
    end
  end

  describe 'find a medication assignments for a student' do
    it 'should show the medication details for a student' do
      medication_assignment = double('MedicationAssignment', :id => '1', :medication_id => 1, :student_id => 1, :nurse_id => 1)
      expect(MedicationAssignment).to receive(:find).with('1').and_return(medication_assignment)
      get :show, :id => '1', :student_id => 1
      expect(response).to render_template('show')
    end
  end

  describe 'delete a medication assignment for a student' do
    it 'should delete a medication assignment for a student' do
      medication_assignment = double('MedicationAssignment', :id => '1', :medication_id => 1, :student_id => 1, :nurse_id => 1)
      expect(MedicationAssignment).to receive(:find).with('1').and_return(medication_assignment)
      expect(medication_assignment).to receive(:destroy)
      delete :destroy, :student_id => 1, :id => '1'
      expect(response).to redirect_to(student_medication_assignments_path)
    end
  end

  describe 'redirect when appropriate' do
    it 'index redirects wrong student' do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "stone@tip.com", "password" => "12345"}}

      @controller = MedicationAssignmentsController.new
      get :index, student_id: 1
      expect(response).to redirect_to(login_path)
    end
    it 'index allows right student' do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "david@wang.com", "password" => "12345"}}

      @controller = MedicationAssignmentsController.new
      get :index, student_id: 1
      expect(response).to render_template('index')
    end

    it 'new redirects student' do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "stone@tip.com", "password" => "12345"}}

      @controller = MedicationAssignmentsController.new
      get :new, student_id: 3
      expect(response).to redirect_to(login_path)
    end

    it 'new redirects admin' do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "hell@bear.com", "password" => "12345"}}

      @controller = MedicationAssignmentsController.new
      get :new, student_id: 3
      expect(response).to redirect_to(login_path)
    end

    it 'new allows nurse' do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "inco@gnito.com", "password" => "12345"}}

      @controller = MedicationAssignmentsController.new
      get :new, student_id: 3
      expect(response).to render_template('new')
    end
  end
end