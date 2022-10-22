require 'dotenv'
require_relative 'api/vultr_api/v2/client'

Dotenv.load('credentials.env')

@client = Vultr::Client.new(api_key: ENV['VULTR_API_KEY'])
