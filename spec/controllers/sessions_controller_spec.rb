require 'spec_helper'
require 'rails_helper'

describe SessionsController do

  describe 'test logout' do
    it 'should redirect to login' do
      post :destroy, {"email" => 'a@a.com', "password" => '1'}, {:session_token => "test"}
      expect(response).to redirect_to(login_path)
    end

    it 'should nullify session token' do
      post :destroy, {"email" => 'a@a.com', "password" => '1'}, {:session_token => "test"}
      expect(session[:session_token]).to equal(nil )
    end

    it 'should nullify current user' do
      post :destroy, {"email" => 'a@a.com', "password" => '1'}, {:session_token => "test"}
      expect(assigns(:current_user)).to eq(nil)
    end
  end


  describe 'test login' do
    before :each do
      @fake_user = double('User', :email => 'a@a.com', :session_token => 'testing')
      allow(@fake_user).to receive(:authenticate).and_return(true)
      allow(@fake_user).to receive(:administrator).and_return nil
      allow(@fake_user).to receive(:nurse).and_return nil
      allow(@fake_user).to receive(:guardian).and_return nil
      allow(@fake_user).to receive(:student).and_return nil
    end

    it 'should try to find user' do
      expect(User).to receive(:find_by_email).and_return(@fake_user)
      post :create, {"session" => {"email" => 'a@a.com', "password" => '12345'}}
    end

    it 'should try to authenticate user' do
      expect(@fake_user).to receive(:authenticate).and_return(true)
      expect(User).to receive(:find_by_email).and_return(@fake_user)
      post :create, {"session" => {"email" => 'a@a.com', "password" => '12345'}}
    end

    it 'should notify false login' do
      expect(User).to receive(:find_by_email).and_return(nil)
      post :create, {"session" => {"email" => 'a@a.com', "password" => '1'}}
      expect(flash[:warning]).to match(/Failed to log in/)
    end

    it 'should rerender login on false login' do
      expect(User).to receive(:find_by_email).and_return(nil)
      post :create, {"session" => {"email" => 'a@a.com', "password" => '1'}}
      expect(response).to redirect_to(login_path)
    end

    it 'should try to access administrator' do
      fake_admin = double('Admin', :id=>1)
      expect(@fake_user).to receive(:administrator).and_return fake_admin
      allow(User).to receive(:find_by_email).and_return(@fake_user)
      post :create, {"session" => {"email" => 'a@a.com', "password" => '12345'}}
    end

    it 'should try to access nurse if not administrator' do
      fake_nurse = double('Nurse')
      expect(@fake_user).to receive(:nurse).twice.and_return 1
      allow(User).to receive(:find_by_email).and_return(@fake_user)
      post :create, {"session" => {"email" => 'a@a.com', "password" => '12345'}}
    end


    it 'should try to access guardian if not nurse' do
      fake_guardian = double('Guardian')
      expect(@fake_user).to receive(:guardian).twice.and_return 1
      allow(User).to receive(:find_by_email).and_return(@fake_user)
      post :create, {"session" => {"email" => 'a@a.com', "password" => '12345'}}
    end


    it 'should try to access student if not guardian' do
      fake_student = double('Student', :id => 1)
      expect(@fake_user).to receive(:student).twice.and_return(fake_student)
      allow(fake_student).to receive(:[]).with(:id).and_return 1
      allow(User).to receive(:find_by_email).and_return(@fake_user)
      post :create, {"session" =>  {"email" => 'a@a.com', "password" => '12345'}}
    end


    it 'should set session token in session' do
      allow(User).to receive(:find_by_email).and_return(@fake_user)
      expect(@fake_user).to receive(:student).twice.and_return(1)
      post :create,{"session" =>  {"email" => 'a@a.com', "password" => '12345'}}
      expect(session[:session_token]).to equal(@fake_user.session_token)
    end


    it 'should redirect nurse to nurse schedule' do
      fake_nurse = double('Nurse')
      allow(@fake_user).to receive(:nurse).twice.and_return 1
      allow(fake_nurse).to receive(:id).and_return 1
      allow(User).to receive(:find_by_email).and_return(@fake_user)
      post :create, {"session" => {"email" => 'a@a.com', "password" => '12345'}}
      expect(response).to redirect_to('/nurses/1')
    end


    it 'should redirect student to student schedule' do

      fake_student = double('Nurse')
      expect(@fake_user).to receive(:student).twice.and_return(1)
      allow(fake_student).to receive(:send).and_return 1
      allow(User).to receive(:find_by_email).and_return(@fake_user)
      post :create, {"session" => {"email" => 'a@a.com', "password" => '12345'}}
      expect(response).to redirect_to('/students/1')
    end

    it 'should redirect guardians to guardians schedule' do
      fake_guardian = double('Guardian')
      expect(@fake_user).to receive(:guardian).twice.and_return 1
      allow(fake_guardian).to receive(:send).and_return 1
      allow(User).to receive(:find_by_email).and_return(@fake_user)
      post :create, {"session" => {"email" => 'a@a.com', "password" => '12345'}}
      expect(response).to redirect_to('/guardians/1')
    end

    it 'should redirect administrators to administrators schedule' do
      fake_administrator = double('Administrator')
      expect(@fake_user).to receive(:administrator).and_return fake_administrator
      allow(fake_administrator).to receive(:id).and_return 1
      allow(User).to receive(:find_by_email).and_return(@fake_user)
      post :create, {"session" => {"email" => 'a@a.com', "password" => '12345'}}
      expect(response).to redirect_to('/administrators/stats')
    end

    it 'should if already logged in' do
      post :create, {"session" => {"email" => 'inco@gnito.com', "password" => '12345'}}
      get :new
      expect(response).to redirect_to('/nurses/2')
    end

  end
end