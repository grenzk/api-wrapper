require 'dotenv'
require_relative 'api/youtube_api/v3/client'

Dotenv.load('credentials.env')

@client = YouTube::Client.new(api_key: ENV['YOUTUBE_API_KEY'])

@client.connection.get(
  'videos',
  {
    id: '7lCDEYXw3mM',
    key: "#{@client.api_key}",
    part: 'snippet,contentDetails,statistics,status'
  }
)
