# YouTube API Wrapper

- Get all your channel's playlists using YouTube's Data API in Ruby.
- Get information about a specific YouTube video.

## Usage

```ruby
# Set a client with your own API key
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
    key: "#{client.api_key}"
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

## Retrieve information about a specific video

```ruby
client.connection.get(
  'videos',
  {
    id: '7lCDEYXw3mM',
    key: "#{client.api_key}",
    part: 'snippet,contentDetails,statistics,status'
  }
)
```

## Source

YouTube API Reference (https://developers.google.com/youtube/v3/docs)
