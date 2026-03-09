require 'rails_helper'

RSpec.describe "Admin::Users", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/user/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/admin/user/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/admin/user/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
