require 'spec_helper'
require 'rails_helper'

describe NursesController do

  before :each do
    @controller = SessionsController.new
    post :create, {"session" => {"email" => "hell@bear.com", "password" => "12345"}}

    @controller = NursesController.new
  end

  describe 'show form to add nurse' do
    it 'should show the form for administrator to create new nurse' do
      get(:new, params: {})
      expect(response).to render_template('new')
    end
  end

  describe 'create a nurse' do
    it 'should create a nurse successfully' do
      nurse = double('Nurse', :first_name => 'Jane', :last_name => 'Doe', :school_id => 2)
      hash = {:school_id => 2}
      allow(Nurse).to receive(:create!).and_return(nurse)
      allow_any_instance_of(NursesController).to receive(:nurse_params).and_return(hash)
      allow_any_instance_of(NursesController).to receive(:user_params).and_return({:first_name => 'Jane', :last_name => 'Doe', :email => "a@a.com"})
      post(:create, params: {:nurse => hash})
      expect(response).to redirect_to(nurses_path)
    end

    it 'should fail nurse creation with existing email' do
      nurse = double('Nurse', :first_name => 'Jane', :last_name => 'Doe', :school_id => 2)
      hash = {:school_id => 2}
      allow(Nurse).to receive(:create!).and_return(nurse)

      allow_any_instance_of(NursesController).to receive(:nurse_params).and_return(hash)
      allow_any_instance_of(NursesController).to receive(:user_params).and_return({:first_name => 'Jane', :last_name => 'Doe', :email => "inco@gnito.com"})

      post(:create, params: {:nurse => hash})
      expect(response).to redirect_to(new_nurse_path)
    end
  end

  describe 'edit a nurse' do
    it 'should show the form to edit the nurse info' do
      nurse = double('Nurse', :id => '1', :school_id => 1)
      allow(Nurse).to receive(:find).with('1').and_return(nurse)
      get :edit, :id => '1'
      expect(response). to render_template('edit')
    end
  end

  describe 'update a nurse' do
    it 'should save the updated nurse info' do
      nurse = double('Nurse', :first_name => 'John', :last_name => 'Smith', :school_id => 2)
      hash = {:first_name => "Arg"}
      fake_user = double('User')
      allow(fake_user).to receive(:update_attributes!)
      allow(fake_user).to receive(:first_name)
      allow(fake_user).to receive(:last_name)
      allow(Nurse).to receive(:find).with('1').and_return(nurse)
      allow(nurse).to receive(:update_attributes!)
      allow(nurse).to receive(:user).and_return(fake_user)
      allow(nurse).to receive(:delete_if).and_return(nurse)

      allow_any_instance_of(NursesController).to receive(:nurse_params).and_return(hash)
      allow_any_instance_of(NursesController).to receive(:user_params).and_return({:first_name => 'John', :last_name => 'Smith', :email => "a@a.com"})
      allow_any_instance_of(NursesController).to receive(:nurse_params).and_return(nurse)

      put :update, :id => '1'
      expect(response).to redirect_to(nurses_path)
    end
  end

  describe 'find a nurse' do
    it 'should show nurse schedule' do
      ## THIS IS DIFFERENT
    end
  end

  describe 'list all nurses' do
    it 'should find and list all nurses' do
      fake_results = [double('Nurse'), double('Nurse')]
      expect(Nurse).to receive(:all).and_return(fake_results)
      get :index
      expect(response).to render_template('index')
    end
  end

end