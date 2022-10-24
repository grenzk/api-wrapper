# frozen_string_literal: true

require 'dotenv'
require 'json'
require_relative 'api/youtube_api/v3/client'

Dotenv.load('credentials.env')

client =
  YouTube::Client.new(
    api_key: ENV['YOUTUBE_API_KEY'],
    access_token: ENV['YOUTUBE_ACCESS_TOKEN']
  )

client.connection.get(
  'playlists',
  {
    part: 'snippet,contentDetails',
    mine: true,
    maxResults: 25,
    key: client.api_key
  }
)

client.connection.get(
  'videos',
  {
    id: '7lCDEYXw3mM',
    key: client.api_key,
    part: 'snippet,contentDetails,statistics,status'
  }
)

client
  .connection
  .post('playlists') do |req|
    req.params['part'] = 'snippet,contentDetails'
    req.params['key'] = client.api_key
    req.body = { snippet: { title: 'My Playlist' } }.to_json
  end
