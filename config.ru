require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

Mailer = Faraday.new(:url => 'https://api.mailgun.net/v2') do |faraday|
  faraday.request  :url_encoded
  faraday.adapter  Faraday.default_adapter
end

Mailer.basic_auth('api', '<your api key>')

MailerParams = {
  :from => 'John Doe <john@doe.com>',
  :to => 'mr@president.com',
  :subject => 'Some information',
}

class App < Sinatra::Base
	
	get '/' do
		Mailer.post('<your domain>/messages', MailerParams.merge({:text => params.inspect}))
	end
	
	post '/' do
		Mailer.post('<your domain>/messages', MailerParams.merge({:text => params.inspect}))
	end

end

run App
