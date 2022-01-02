require 'spec_helper'
require 'rails_helper'

describe StudentsController do

  before :each do
    @controller = SessionsController.new
    post :create, {"session" => {"email" => "putin@vlad.com", "password" => "12345"}}

    @controller = GuardiansController.new
    @user = double('User', :first_name => 'John', :last_name => 'Smith', :email => "a@a.com",
                  :student => nil, :guardian => nil, :administrator => nil, :nurse => nil)
    @guardian = double('Guardian', :id => '1', :user => @user)
    allow(@user).to receive(:guardian).and_return(@guardian)
    allow(User).to receive(:find_by_session_token).and_return(@user)
  end


  describe 'login redirect' do
    it 'should redirect to login on other pages when not logged in' do

      @controller = SessionsController.new
      post :destroy
      @controller = GuardiansController.new

      allow(User).to receive(:find_by_session_token).and_return(nil)
      get :show, {:id => 1}
      expect(response).to redirect_to('/login')
    end
  end

  describe 'find a guardian' do
    it 'should show the guardian information' do

      expect(@guardian).to receive(:students).twice.and_return([])

      get :show, {:id => '1'}
      expect(response).to render_template('show')
    end

    it 'should show only current guardian for guardian login' do

      allow(@guardian).to receive(:students).and_return([])

      get :show, {:id => '1'}
      expect(response).to render_template('show')
      expect(assigns(:guardian)).to eq(@user.guardian)
    end

    it 'should assign guardian by id if nurse' do
      guardian = double('GuardX', :id => '1', :user => @user)
      expect(Guardian).to receive(:find).with('1').and_return(guardian)
      allow(guardian).to receive(:students).and_return([])

      allow(@user).to receive(:guardian).and_return(nil)
      get :show, {:id => '1'}
      expect(assigns(:guardian)).to eq(guardian)
    end

    it 'should redirect if student and not correct guardian' do
      student = double('Student', :id => '1', :user => @user)
      allow(student).to receive(:guardians).and_return([])

      allow(@user).to receive(:student).twice.and_return(student)
      get :show, {:id => '1'}
      expect(response).to redirect_to('/login')
    end

    it 'should render if student and correct guardian' do
      guardian = double('GuardX', :id => '1', :user => @user)
      allow(guardian).to receive(:students).and_return([])
      student = double('Student', :id => '1', :user => @user)
      allow(student).to receive(:guardians).and_return([guardian])
      allow(@user).to receive(:student).twice.and_return(student)
      get :show, {:id => '1'}

      expect(assigns(:guardian)).to eq(guardian)
      expect(response).to render_template('show')
    end

    it 'should assign meetings' do
      user = double('User', :first_name => 'John', :last_name => 'Smith')
      student = double('Student', :id => '1', :user => user)
      meeting = double('Meeting', :id => '1', :student => student)
      allow(Guardian).to receive(:find).with('1').and_return(@guardian)
      allow(student).to receive(:meetings).and_return([meeting])
      allow(@guardian).to receive(:students).and_return([student])
      get :show, {:id => '1'}
      expect(assigns(:meetings)).to eq([meeting])
    end
  end

end