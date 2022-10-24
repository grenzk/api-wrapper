# YouTube API Wrapper


- Get all your channel's playlists using YouTube's Data API in Ruby.
- Get information about a specific YouTube video.

## Usage

```ruby
# Set a client with your own API key
client = YouTube::Client.new(api_key: ENV['YOUTUBE_API_KEY'])
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
  },
  # Access Token is required
  { Authorization: "Bearer #{ENV['YOUTUBE_ACCESS_TOKEN']}" }
)
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
