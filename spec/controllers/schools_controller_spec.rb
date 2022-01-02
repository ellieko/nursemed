require 'spec_helper'
require 'rails_helper'

describe SchoolsController do

  before :each do
    @controller = SessionsController.new
    post :create, {"session" => {"email" => "hell@bear.com", "password" => "12345"}}

    @controller = SchoolsController.new
  end

  describe 'new school form' do
    it 'should show the form for a new school' do
      get(:new, params: {})
      expect(response).to render_template('new')
    end
  end

  describe 'create school' do
    it 'should create school successfully' do
      school = double('School', :name => 'High School')
      allow(School).to receive(:create!).and_return (school)
      allow_any_instance_of(SchoolsController).to receive(:school_params).and_return (school)
      post :create, :school => school
      expect(response).to redirect_to(schools_path)
    end
  end

  describe 'list all schools' do
    it 'should find and list all schools' do
      fake_results = [double('School'), double('School')]
      expect(School).to receive(:all).and_return(fake_results)
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'edit a school' do
    it 'should show the form to edit a school' do
      school = double('School', :id => 1, :name => 'High School')
      allow(School).to receive(:find).with('1').and_return(school)
      get :edit, :id => '1'
      expect(response). to render_template('edit')
    end
  end

  describe 'update a school' do
    it 'should save the updated school info' do
      school = double('School', :id => 1, :name => 'High School')
      allow(School).to receive(:find).with('1').and_return(school)
      allow(school).to receive(:update_attributes!)
      allow_any_instance_of(SchoolsController).to receive(:school_params).and_return (school)
      put :update, :id => '1', :school => school
      expect(response).to redirect_to(school_path(school))
    end
  end

  describe 'find a school' do
    it 'should show the school detail' do
      school = double('School', :id => 1, :name => 'High School')
      expect(School).to receive(:find).with('1').and_return(school)
      get :show, :id => '1'
      expect(response).to render_template('show')
    end
  end

  describe 'delete a school' do
    it 'should delete a school' do
      school = double('School', :id => 1, :name => 'High School')
      expect(School).to receive(:find).with('1').and_return(school)
      expect(school).to receive(:destroy)
      expect(school).to receive(:students).and_return([])
      expect(school).to receive(:nurses).and_return([])
      delete :destroy, :id => '1'
      expect(response).to redirect_to(schools_path)
    end

    it 'should not delete school with students' do
      school = double('School', :id => 1, :name => 'High School')
      student = [double('Student', :school => school)]
      expect(School).to receive(:find).with('1').and_return(school)
      expect(school).to_not receive(:destroy)
      expect(school).to receive(:students).and_return(student)
      delete :destroy, :id => '1'
      expect(response).to redirect_to(schools_path)
    end

  it 'should not delete school with nurses' do
    school = double('School', :id => 1, :name => 'High School')
    nurse = [double('Nurse', :school => school)]
    expect(School).to receive(:find).with('1').and_return(school)
    expect(school).to_not receive(:destroy)
    expect(school).to receive(:students).and_return([])
    expect(school).to receive(:nurses).and_return(nurse)
    delete :destroy, :id => '1'
    expect(response).to redirect_to(schools_path)
  end

  it 'should redirect any non-admin' do
    @controller = SessionsController.new
    post :create, {"session" => {"email" => "inco@gnito.com", "password" => "12345"}}

    @controller = SchoolsController.new

    delete :destroy, :id => '1'
    expect(response).to redirect_to(login_path)
    delete :index
    expect(response).to redirect_to(login_path)
    delete :show, :id => '1'
    expect(response).to redirect_to(login_path)
  end

end

end