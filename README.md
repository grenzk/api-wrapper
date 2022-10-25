# YouTube API Wrapper

Create, modify, or delete a playlist using YouTube Data API in Ruby.

## Installation

Install these gems:

```ruby
gem install faraday
gem install json
```

and require them in your file:

```ruby
require 'faraday'
require 'json'
```

## Usage

```ruby
# Set a client with your own api key and access token
client =
  YouTube::Client.new(
    api_key: ENV['YOUTUBE_API_KEY'],
    access_token: ENV['YOUTUBE_ACCESS_TOKEN']
  )
```

## List all your channel's playlists

```ruby
client.connection.get(
  'playlists',
  {
    part: 'snippet,contentDetails',
    mine: true,
    maxResults: 25,
    key: client.api_key
  }
)
```

## Create a playlist

```ruby
client
  .connection
  .post('playlists') do |req|
    req.params['part'] = 'snippet,contentDetails'
    req.params['key'] = client.api_key
    req.body = { snippet: { title: 'My Playlist' } }.to_json
  end
```

## Update a playlist

```ruby
# The example code modifies a playlist's title and description
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
```

## Delete a playlist

```ruby
# id must be specified
client.connection.delete(
  'playlists',
  { id: 'PLUaqlQySlU3uYObrz81amkmoE46XG1Z89', key: client.api_key }
)
```

## Add a video to your playlist

```ruby
# playlistId and resourceId must be specified
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
```

## Remove a video from your playlist

```ruby
client.connection.delete(
  'playlistItems',
  {
    id: 'UExVYXFsUXlTbFUzdmo2STY2eXYyaGdOTWhKOEw3SFJadi41NkI0NEY2RDEwNTU3Q0M2',
    key: client.api_key
  }
)
```

## Source

YouTube API Reference (https://developers.google.com/youtube/v3/docs)
