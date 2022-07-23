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
          'user.fields': 'description,profile_image_url'
        }
        send_request(:get, '/2/users/me', params)
      end

      def my_tweets
        params = {
          'exclude': 'retweets,replies',
          'max_results': 50
        }
        send_request(:get, "/2/users/#{@user.twitter_id}/tweets", params)
      end

      def liked_tweets
        params = {
          'max_results': 50,
          'expansions': 'author_id'
        }
        send_request(:get, "/2/users/#{@user.twitter_id}/liked_tweets", params)
      end

      def my_bookmarks
        params = {
          'tweet.fields': 'context_annotations,created_at',
          'expansions': 'author_id',
          'user.fields': 'profile_image_url'
        }
        send_request(:get, "/2/users/#{@user.twitter_id}/bookmarks", params)
      end

      private

      def send_request(http_method, endpoint, params = {})
        connection = Faraday.new(
          url: BASE_URL,
          params:,
          headers: { 'Authorization' => "Bearer #{@user.token}" }
        )

        response = connection.public_send(http_method, endpoint)
        JSON.parse(response.body)["data"]
      end
    end
  end
end
