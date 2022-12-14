# frozen_string_literal: true

require 'dotenv'
require 'json'
require_relative 'api/youtube_api/v3/client'

Dotenv.load('credentials.env')

# Set a client
client =
  YouTube::Client.new(
    api_key: ENV['YOUTUBE_API_KEY'],
    access_token: ENV['YOUTUBE_ACCESS_TOKEN']
  )

# List all playlists of a specified channel
client.connection.get(
  'playlists',
  {
    part: 'snippet,contentDetails',
    mine: true,
    maxResults: 25,
    key: client.api_key
  }
)

# Create a new playlist
client
  .connection
  .post('playlists') do |req|
    req.params['part'] = 'snippet,contentDetails'
    req.params['key'] = client.api_key
    req.body = { snippet: { title: 'My Playlist' } }.to_json
  end

# Update a playlist
client
  .connection
  .put('playlists') do |req|
    req.params['part'] = 'snippet,contentDetails'
    req.params['key'] = client.api_key
    req.body = {
      id: 'PLUaqlQySlU3uYObrz81amkmoE46XG1Z89',
      snippet: {
        title: 'New Playlist',
        description: 'This is a new playlist.'
      }
    }.to_json
  end

# Delete a playlist
client.connection.delete(
  'playlists',
  { id: 'PLUaqlQySlU3uYObrz81amkmoE46XG1Z89', key: client.api_key }
)

# Add a video to a playlist
client
  .connection
  .post('playlistItems') do |req|
    req.params['part'] = 'snippet'
    req.params['key'] = client.api_key
    req.body = {
      snippet: {
        playlistId: 'PLUaqlQySlU3vj6I66yv2hgNMhJ8L7HRZv',
        resourceId: {
          kind: 'youtube#video',
          videoId: 'N3oCS85HvpY'
        }
      }
    }.to_json
  end

# Delete a video from a playlist
client.connection.delete(
  'playlistItems',
  {
    id: 'UExVYXFsUXlTbFUzdmo2STY2eXYyaGdOTWhKOEw3SFJadi41NkI0NEY2RDEwNTU3Q0M2',
    key: client.api_key
  }
)
