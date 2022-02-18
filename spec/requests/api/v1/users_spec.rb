require 'rails_helper'

describe "/api/v1/login" do
  let!(:user) { create :user }
  let!(:stubbed_token) { 'my token' }


  context "login" do
    before do
      allow(JWT).to receive(:encode).and_return(stubbed_token)
    end

    it "logs the existing user in" do
      post "/api/v1/login", params: { email: user.email, password: "password" }

      expect(response).to have_http_status :success
      expect(response_json.keys).to contain_exactly :token, :exp, :email
      expect(response_json[:token]).to eq stubbed_token
      expect(response_json[:email]).to eq user.email
    end

    it "returns a 401 for non-existing users" do
      post "/api/v1/login", params: { email: 'non-existent-user@example.com', password: "foo" }
      expect(response).to have_http_status :unauthorized
      expect(response_json.keys).to contain_exactly :error
    end
  end
end
