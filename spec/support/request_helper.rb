module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body, symbolize_names: true) if response.body.present?
    end

    def authenticated_header(user = create(:user), exp = nil)
      if exp.present?
        allow(JsonWebToken).to receive(:expiration).and_return(exp)
      end
      token = JsonWebToken.encode(sub: user.id)
      { 'Authorization': "Bearer #{token}" }
    end
  end
end
