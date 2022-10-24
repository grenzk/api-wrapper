require 'faraday'

module YouTube
  class Client
    BASE_URL = 'https://www.googleapis.com/youtube/v3/'

    attr_reader :api_key, :access_token, :adapter

    def initialize(api_key:, access_token:, adapter: Faraday.default_adapter)
      @api_key = api_key
      @adapter = adapter
      @access_token = access_token
    end

    def connection
      @connection ||=
        Faraday.new do |conn|
          conn.url_prefix = BASE_URL
          conn.request :json
          conn.response :json, content_type: 'application/json'
          conn.adapter adapter
          conn.request :authorization, 'Bearer', "#{access_token}"
        end
    end

    def inspect
      '#<YouTube::Client>'
    end
  end
end
