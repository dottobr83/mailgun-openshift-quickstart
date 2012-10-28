require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

conn = Faraday.new(:url => 'https://api.mailgun.net/v2') do |faraday|
  faraday.request  :url_encoded
  faraday.response :logger
  faraday.adapter  Faraday.default_adapter
end

conn.basic_auth('api', '<you api>')

params = {
  :from => 'John Doe <john@doe.com>',
  :to => 'mr@president.com',
  :subject => 'Hello',
  :text => 'Testing some Mailgun from OpenShift!'
}

conn.post('<your domain>/messages', params)