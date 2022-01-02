require 'rails_helper'

RSpec.describe "Students", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/students/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/students/1/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /index" do
    it "returns http success" do
      get "/students"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/students/1"
      expect(response).to have_http_status(:success)
    end
  end

end
