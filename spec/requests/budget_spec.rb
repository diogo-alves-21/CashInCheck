require 'rails_helper'

RSpec.describe "Budgets", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/budgets/index"
      expect(response).to have_http_status(:success)
    end
  end

end
