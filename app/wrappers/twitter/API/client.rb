# frozen_string_literal: true

module Twitter
  module API
    class Client
      BASE_URL = 'https://api.twitter.com'

      def initialize(user)
        @user = user
      end

      def me
        params = { 
          'user.fields': 'description', 
        }
        send_request(:get, '/2/users/me', params )
      end

      def my_tweets
        send_request(:get, "/2/users/#{@user.twitter_id}/tweets")
      end

      private

      def send_request(http_method, endpoint, params = {})
        connection = Faraday.new(
          url: BASE_URL,
          params:,
          headers: { 'Authorization' => "Bearer #{@user.token}" }
        )
        
        response = connection.public_send(http_method, endpoint)
        JSON.parse(response.body)
      end
    end
  end
end
