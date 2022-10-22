require_relative 'api/vultr_api/v2/client'

client = Vultr::Client.new(api_key: ENV['VULTR_API_KEY'])


