require 'rails_helper'

describe "/api/v1/login" do
  let!(:user) { create :user }

  context "login" do
    it "logs the existing user in" do
      post "/api/v1/login", params: { email: user.email, password: "password" }
      expect(response).to have_http_status :success
      expect(response_json.keys).to contain_exactly :id, :email
    end

    it "returns a 401 for non-existing users" do
    end
  end
end
