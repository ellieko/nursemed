require 'spec_helper'
require 'rails_helper'

describe AdministratorsController do
  before :each do
    @controller = SessionsController.new
    post :create, {"session" => {"email" => "hell@bear.com", "password" => "12345"}}

    @controller = AdministratorsController.new
  end

  describe 'should make graphs for stats page' do
    it 'assigns charts' do
      get :stats
      expect(assigns(:chart)).to_not be_nil
      expect(assigns(:chart_globals)).to_not be_nil
    end
  end
end
