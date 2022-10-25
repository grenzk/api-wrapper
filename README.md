# YouTube API Wrapper

- Create, modify, or delete a playlist using the YouTube API wrapper in Ruby.

## Installation

Install these gems:
```ruby
gem install faraday
gem install json
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

## Source

YouTube API Reference (https://developers.google.com/youtube/v3/docs)
