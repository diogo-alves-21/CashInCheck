require 'rails_helper'

RSpec.describe "Wallets", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/wallets/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show," do
    it "returns http success" do
      get "/wallets/show,"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new," do
    it "returns http success" do
      get "/wallets/new,"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/wallets/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
