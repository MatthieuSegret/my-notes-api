module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body, symbolize_names: true)
    end

    def authenticated_header(user = create(:user))
      token = user.generate_token!
      { 'Authorization': "Bearer #{token}" }
    end
  end
end
