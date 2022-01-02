require 'spec_helper'
require 'rails_helper'

describe NursesController do

  before :each do
    @controller = SessionsController.new
    post :create, {"session" => {"email" => "hell@bear.com", "password" => "12345"}}

    @controller = NursesController.new

    @user = double('User', :first_name => 'John', :last_name => 'Smith', :email => "a@a.com",
                   :student => nil, :guardian => nil, :administrator => nil, :nurse => nil)
    @meetings = double('Meetings', where: [])
    @nurse = double('Nurse', :id => '1', :user => @user, :meetings => @meetings)
    allow(@user).to receive(:nurse).and_return(@nurse)
    allow(User).to receive(:find_by_session_token).and_return(@user)
  end

  describe 'find a nurse' do
    it 'should show the nurse information' do
      allow(User).to receive(:find_by_session_token).and_call_original

      get :show, {:id => '1'}
      expect(response).to render_template('show')
    end

    it 'should access db if admin' do
      allow(@user).to receive(:nurse).and_return(nil)
      allow(@user).to receive(:administrator).and_return("")
      get :show, {:id => '1'}
      expect(assigns(:nurse)).to eq(Nurse.find(1))
    end

    it 'should show the current nurse information if nurse' do
      @controller = SessionsController.new
      post :create, {"session" => {"email" => "inco@gnito.com", "password" => "12345"}}
      @controller = NursesController.new
      allow(User).to receive(:find_by_session_token).and_call_original

      get :show, {:id => '1'}
      expect(assigns(:nurse)).to eq(Nurse.find(2))
    end
  end

  describe 'pages should redirect when approriate' do
    it 'show should non-nurse, non-admin' do

      allow(@user).to receive(:nurse).and_return(nil)
      get :show, {:id => 1}
      expect(response).to redirect_to('/login')
    end


  end

end